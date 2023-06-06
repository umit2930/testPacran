import 'package:bloc/bloc.dart';
import 'package:dobareh_bloc/data/model/order/order_response.dart';
import 'package:dobareh_bloc/data/repository/order_repository.dart';
import 'package:dobareh_bloc/utils/app_exception.dart';

part 'order_details_state.dart';

class OrderDetailsCubit extends Cubit<OrderDetailsState> {
  OrderDetailsCubit({required int orderID})
      : _orderRepository = OrderRepository(),
        super(OrderDetailsState(
            orderDetailsStatus: OrderDetailsStatus.init, orderID: orderID));

  final OrderRepository _orderRepository;

  void getOrderDetails() async {
    emit(state.copyWith(orderDetailsStatus: OrderDetailsStatus.loading));
    try {
      var response = await _orderRepository.getDetails(state.orderID);
      emit(state.copyWith(
          orderDetailsStatus: OrderDetailsStatus.success,
          orderResponse: response));
    } on AppException catch (appException) {
      emit(state.copyWith(
          orderDetailsStatus: OrderDetailsStatus.error,
          errorMessage: appException.toString()));
    } catch (e) {
      emit(state.copyWith(
          orderDetailsStatus: OrderDetailsStatus.error,
          errorMessage: e.toString()));
    }
  }
}
