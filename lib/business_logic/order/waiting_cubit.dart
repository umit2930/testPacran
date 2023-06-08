import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

import '../../data/model/calculate_values/OrederStatusResponse.dart';
import '../../data/repository/order_repository.dart';
import '../../utils/app_exception.dart';

part 'waiting_state.dart';

class WaitingCubit extends Cubit<WaitingState> {
  WaitingCubit({required int orderID})
      : _orderRepository = Get.find(),
        super(WaitingState(
            orderStatusStatus: OrderStatusStatus.init, orderID: orderID));

  final OrderRepository _orderRepository;
  Timer? timer;

  void orderStatusRequested() async {
    timer = Timer.periodic(const Duration(seconds: 15), (timer) async {
      emit(state.copyWith(orderStatusStatus: OrderStatusStatus.loading));
      try {
        var response =
            await _orderRepository.checkStatus(orderID: state.orderID);
        emit(state.copyWith(
            orderStatusStatus: OrderStatusStatus.success,
            orderStatusResponse: response));
      } on AppException catch (appException) {
        emit(state.copyWith(
            orderStatusStatus: OrderStatusStatus.error,
            errorMessage: appException.toString()));
      } catch (e) {
        emit(state.copyWith(
            orderStatusStatus: OrderStatusStatus.error,
            errorMessage: e.toString()));
      }
    });
  }

  void orderStatusClosed() {
    timer?.cancel();
    timer = null;
  }
}
