import 'package:bloc/bloc.dart';
import 'package:dobareh_bloc/data/model/home/home_response.dart'
    as home_response;
import 'package:dobareh_bloc/data/model/order/orders_list_response.dart';
import 'package:dobareh_bloc/data/repository/order_repository.dart';
import 'package:dobareh_bloc/data/repository/user_repository.dart';
import 'package:dobareh_bloc/utils/app_exception.dart';
import 'package:dobareh_bloc/utils/enums.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import '../home/home_cubit.dart';

part 'orders_list_state.dart';

class OrdersListCubit extends Cubit<OrdersListState> {
  OrdersListCubit({required Jalali todayDate})
      : _orderRepository = Get.find(),
        _userRepository = Get.find(),
        super(OrdersListState(
          waitingOrdersStatus: WaitingOrdersStatus.initial,
          deliveredOrdersStatus: DeliveredOrdersStatus.initial,
          selectedDate: Jalali.now(),
          todayDate: todayDate,
        ));

  final OrderRepository _orderRepository;
  final UserRepository _userRepository;

  void tabSelected({required int index}) {
    emit(state.copyWith(selectedTab: index));
  }

  void timePackSelected({required int index}) {
    emit(state.copyWith(selectedTimePackID: index));
  }

  void dateSelected({required Jalali date}) {
    emit(state.copyWith(selectedDate: date));
  }

  void waitingOrdersRequested() async {
    try {
      emit(state.copyWith(waitingOrdersStatus: WaitingOrdersStatus.loading));
      var response = await _userRepository.getHome();

      //TODO find better way.
      emit(OrdersListState(
          waitingOrdersStatus: WaitingOrdersStatus.success,
          waitingOrdersResponse: response,
          waitingPacks: extractTimePacks(response),
          inProgressOrder: getInProgressOrder(response),
          deliveredOrdersStatus: state.deliveredOrdersStatus,
          todayDate: state.todayDate,
          selectedDate: state.selectedDate,
          selectedTab: state.selectedTab,
          selectedTimePackID: state.selectedTimePackID));
    } on AppException catch (appException) {
      emit(state.copyWith(
          waitingOrdersStatus: WaitingOrdersStatus.failure,
          errorMessage: appException.toString()));
    } catch (e) {
      emit(state.copyWith(
          waitingOrdersStatus: WaitingOrdersStatus.failure,
          errorMessage: e.toString()));
    }
  }

  void deliveredOrdersRequested() async {
    try {
      var gregorianDate =
          DateFormat('yyyy-MM-dd').format(state.selectedDate.toDateTime());

      emit(
          state.copyWith(deliveredOrdersStatus: DeliveredOrdersStatus.loading));
      var response = await _orderRepository.getOrders(
          orderStatus: OrderStatus.delivered, date: gregorianDate);
      emit(state.copyWith(
        deliveredOrdersStatus: DeliveredOrdersStatus.success,
        deliveredOrdersResponse: response,
        deliveredOrders: response.orders,
      ));
    } on AppException catch (appException) {
      emit(state.copyWith(
          deliveredOrdersStatus: DeliveredOrdersStatus.failure,
          errorMessage: appException.toString()));
    } catch (e) {
      emit(state.copyWith(
          deliveredOrdersStatus: DeliveredOrdersStatus.failure,
          errorMessage: e.toString()));
    }
  }
}
