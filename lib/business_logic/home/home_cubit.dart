import 'package:bloc/bloc.dart';
import 'package:dobareh_bloc/data/model/home/home_response.dart';
import 'package:dobareh_bloc/data/repository/home_repository.dart';
import 'package:dobareh_bloc/utils/app_exception.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

import '../../utils/enums.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit()
      : _homeRepository = Get.find(),
        super(const HomeState(
          homeStatus: HomeStatus.initial,
        ));

  final HomeRepository _homeRepository;

  void timePackSelected(selectedTimePackID) {
    emit(state.copyWith(selectedTimePackID: selectedTimePackID));
  }

  void getHomeRequested() async {
    try {
      emit(state.copyWith(homeStatus: HomeStatus.loading));
      var response = await _homeRepository.getHome();

      emit(state.copyWith(
          homeStatus: HomeStatus.success,
          homeResponse: response,
          timePacks: extractTimePacks(response),
          inProgressOrder: getInProgressOrder(response)));
    } on AppException catch (appException) {
      emit(state.copyWith(
          homeStatus: HomeStatus.failure,
          errorMessage: appException.toString()));
    } catch (e) {
      emit(state.copyWith(
          homeStatus: HomeStatus.failure, errorMessage: e.toString()));
    }
  }



  Map<DeliveryTime, List<Orders>> extractTimePacks(HomeResponse? model) {
    // inProgressOrder =null;
    Map<DeliveryTime, List<Orders>> timePacks = {};
    if (model != null) {
      ///Extract times
      for (int i = 0; i < model.times!.length - 1; i++) {
        var deliver = DeliveryTime(
            from: num.parse(model.times![i]),
            to: num.parse(model.times![(i + 1)]));
        timePacks[deliver] = [];
      }

      ///put orders on times
      for (var order in model.orders!) {
        for (var time in timePacks.keys) {
          if (time.from == order.deliveryTime!.from &&
              time.to == order.deliveryTime!.to) {
            timePacks[time]?.add(order);

            if (order.status == OrderStatus.onWay.value ||
                order.status == OrderStatus.inLocation.value ||
                order.status == OrderStatus.checkFactor.value) {
              // inProgressOrder = order;
            }
          }
        }
      }
    }
    return timePacks;
  }

  Orders? getInProgressOrder(HomeResponse? model) {
    for (var order in model!.orders!) {
      if (order.status == OrderStatus.onWay.value ||
          order.status == OrderStatus.inLocation.value ||
          order.status == OrderStatus.checkFactor.value) {
        return order;
      }
    }
    return null;
  }
}
