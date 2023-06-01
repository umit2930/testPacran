import 'package:bloc/bloc.dart';
import 'package:dobareh_bloc/data/model/home/home_response.dart';
import 'package:dobareh_bloc/data/repository/home_repository.dart';
import 'package:dobareh_bloc/utils/app_exception.dart';
import 'package:logger/logger.dart';

import '../../utils/enums.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required this.homeRepository})
      : super(const HomeState(
          homeStatus: HomeStatus.initial,
        ));

  HomeRepository homeRepository;

  void timePackSelected(selectedTimePackID) {
    Logger().w(
        "emmited $selectedTimePackID --- times:${state.timePacks.toString()}");
    emit(state.copyWith(selectedTimePackID: selectedTimePackID));
  }

  void getHomeRequested() async {
    try {
      emit(state.copyWith(homeStatus: HomeStatus.loading));
      var response = await homeRepository.getHome();

      emit(state.copyWith(
          homeStatus: HomeStatus.success,
          homeResponse: response,
          timePacks: extractTimePacks(response)));
      Logger().w("success --- times:${state.timePacks?.values.toString()}");
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

            if (order.status == OrderStatus.on_way.value ||
                order.status == OrderStatus.in_location.value ||
                order.status == OrderStatus.check_factor.value) {
              // inProgressOrder = order;
            }
          }
        }
      }

      ///Remove times that are empty
      /*for (int i = 0; i < timePacks.length; i++) {
                          var key = timePacks.keys.elementAt(i);
                          var value = timePacks.values.elementAt(i);
                          if (value.isEmpty) {
                            timePacks.remove(key);
                          }
                        }*/
    }
    return timePacks;
  }
}
