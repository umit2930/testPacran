import 'package:bloc/bloc.dart';
import 'package:dobareh_bloc/data/repository/order_repository.dart';
import 'package:dobareh_bloc/utils/enums.dart';

import '../../utils/app_exception.dart';

part 'change_order_status_state.dart';

class ChangeOrderStatusCubit extends Cubit<ChangeOrderStatusState> {
  ChangeOrderStatusCubit({required int orderID, OrderStatus? orderStatus})
      : _orderRepository = OrderRepository(),
        super(ChangeOrderStatusState(
            changeOrderStatus: ChangeOrderStatus.init,
            orderID: orderID,
            orderStatus: orderStatus));

  final OrderRepository _orderRepository;

  void changeStatus(
      {required OrderStatus orderStatus,
      OrderStatusChangeReason? changeReason}) async {
    emit(state.copyWith(changeOrderStatus: ChangeOrderStatus.loading));
    try {
      await _orderRepository.changeStatus(
          orderID: state.orderID,
          orderStatus: orderStatus,
          changeReason: changeReason);
      //if request return 200, we update the order status with new value.
      emit(state.copyWith(
          changeOrderStatus: ChangeOrderStatus.success,
          orderStatus: orderStatus));
    } on AppException catch (appException) {
      emit(state.copyWith(
          changeOrderStatus: ChangeOrderStatus.error,
          errorMessage: appException.toString()));
    } catch (e) {
      emit(state.copyWith(
          changeOrderStatus: ChangeOrderStatus.error,
          errorMessage: e.toString()));
    }
  }
}
