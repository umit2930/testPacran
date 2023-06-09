import 'package:bloc/bloc.dart';
import 'package:dobareh_bloc/data/model/home/home_response.dart';
import 'package:dobareh_bloc/data/repository/user_repository.dart';
import 'package:dobareh_bloc/utils/app_exception.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:collection/collection.dart';

import '../../utils/enums.dart';

part 'home_assistant.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit()
      : _homeRepository = Get.find(),
        super(const HomeState(
          homeStatus: HomeStatus.initial,
        ));

  final UserRepository _homeRepository;

  void timePackSelected(selectedTimePackID) {
    emit(state.copyWith(selectedTimePackID: selectedTimePackID));
  }

  void getHomeRequested() async {
    try {
      emit(state.copyWith(homeStatus: HomeStatus.loading));
      var response = await _homeRepository.getHome();

      //create new instance because we want to clear inProgressOrder.
      emit(HomeState(
          homeStatus: HomeStatus.success,
          homeResponse: response,
          timePacks: extractTimePacks(response),
          inProgressOrder: getInProgressOrder(response),
      selectedTimePackID: state.selectedTimePackID));
    } on AppException catch (appException) {
      emit(state.copyWith(
          homeStatus: HomeStatus.failure,
          errorMessage: appException.toString()));
    } catch (e) {
      emit(state.copyWith(
          homeStatus: HomeStatus.failure, errorMessage: e.toString()));
    }
  }




}
