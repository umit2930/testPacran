part of 'order_details_cubit.dart';

enum OrderStatus { init, loading, success, error }

class OrderDetailsState {
  final OrderStatus orderStatus;
  final OrderResponse? orderResponse;
  final String? errorMessage;

  final int orderID;

  OrderDetailsState({
    required this.orderStatus,
    required this.orderID,
    this.orderResponse,
    this.errorMessage,
  });

  OrderDetailsState copyWith({
    OrderStatus? orderStatus,
    OrderResponse? orderResponse,
    String? errorMessage,
    int? orderID,
  }) {
    return OrderDetailsState(
      orderStatus: orderStatus ?? this.orderStatus,
      orderResponse: orderResponse ?? this.orderResponse,
      errorMessage: errorMessage ?? this.errorMessage,
      orderID: orderID ?? this.orderID,
    );
  }
}
