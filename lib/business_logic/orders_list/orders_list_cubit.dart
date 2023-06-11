import 'package:bloc/bloc.dart';
import 'package:dobareh_bloc/data/model/order/orders_list_response.dart';
import 'package:dobareh_bloc/data/repository/order_repository.dart';
import 'package:dobareh_bloc/utils/app_exception.dart';
import 'package:dobareh_bloc/utils/enums.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

part 'orders_list_assistant.dart';

part 'orders_list_state.dart';

class OrdersListCubit extends Cubit<OrdersListState> {
  OrdersListCubit({required Jalali todayDate})
      : _orderRepository = Get.find(),
        super(OrdersListState(
          waitingOrdersStatus: WaitingOrdersStatus.initial,
          deliveredOrdersStatus: DeliveredOrdersStatus.initial,
          selectedDate: Jalali.now(),
          todayDate: todayDate,
        ));

  final OrderRepository _orderRepository;

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
      var gregorianDate =
          DateFormat('yyyy-MM-dd').format(Jalali.now().toDateTime());

      emit(state.copyWith(waitingOrdersStatus: WaitingOrdersStatus.loading));
      var response = await _orderRepository.getOrders(
          orderStatus: OrderStatus.waiting, date: gregorianDate);
      emit(state.copyWith(
          waitingOrdersStatus: WaitingOrdersStatus.success,
          waitingOrdersResponse: response,
          waitingPacks: extractTimePacks(response),
          inProgressOrder: getInProgressOrder(response)));
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
