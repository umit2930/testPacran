import 'package:bloc/bloc.dart';
import 'package:dobareh_bloc/data/model/order/order_response.dart';
import 'package:dobareh_bloc/data/repository/order_repository.dart';
import 'package:dobareh_bloc/utils/app_exception.dart';

part 'order_details_state.dart';

class OrderDetailsCubit extends Cubit<OrderDetailsState> {
  OrderDetailsCubit(int orderID)
      : _orderRepository = OrderRepository(),
        super(
            OrderDetailsState(orderStatus: OrderStatus.init, orderID: orderID));

  final OrderRepository _orderRepository;

  void getOrderDetails() async {
    emit(state.copyWith(orderStatus: OrderStatus.loading));
    try {
      var response = await _orderRepository.getOrderDetails(state.orderID);
      emit(state.copyWith(
          orderStatus: OrderStatus.success, orderResponse: response));
    } on AppException catch (appException) {
      emit(state.copyWith(
          orderStatus: OrderStatus.error,
          errorMessage: appException.toString()));
    } catch (e) {
      emit(state.copyWith(
          orderStatus: OrderStatus.error, errorMessage: e.toString()));
    }
  }
}
