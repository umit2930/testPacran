part of 'change_order_status_cubit.dart';

enum ChangeOrderStatus { init, loading, success, error }

class ChangeOrderStatusState {
  final ChangeOrderStatus changeOrderStatus;
  final OrderStatus? orderStatus;
  final String? errorMessage;

  final int orderID;

  ChangeOrderStatusState(
      {required this.changeOrderStatus,
      required this.orderID,
      this.orderStatus,
      this.errorMessage});

  ChangeOrderStatusState copyWith({
    ChangeOrderStatus? changeOrderStatus,
    OrderStatus? orderStatus,
    String? errorMessage,
    int? orderID,
  }) {
    return ChangeOrderStatusState(
      changeOrderStatus: changeOrderStatus ?? this.changeOrderStatus,
      orderStatus: orderStatus ?? this.orderStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      orderID: orderID ?? this.orderID,
    );
  }
}
