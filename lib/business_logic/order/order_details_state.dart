part of 'order_details_cubit.dart';

enum OrderDetailsStatus { init, loading, success, error }

class OrderDetailsState extends Equatable{
  final OrderDetailsStatus orderDetailsStatus;
  final OrderResponse? orderResponse;
  final String? errorMessage;

  final int orderID;

  const OrderDetailsState({
    required this.orderDetailsStatus,
    required this.orderID,
    this.orderResponse,
    this.errorMessage,
  });

  OrderDetailsState copyWith({
    OrderDetailsStatus? orderDetailsStatus,
    OrderResponse? orderResponse,
    String? errorMessage,
    int? orderID,
  }) {
    return OrderDetailsState(
      orderDetailsStatus: orderDetailsStatus ?? this.orderDetailsStatus,
      orderResponse: orderResponse ?? this.orderResponse,
      errorMessage: errorMessage ?? this.errorMessage,
      orderID: orderID ?? this.orderID,
    );
  }

  //TODO check if this prevent rebuild during responsive.
  @override
  List<Object?> get props => [orderDetailsStatus,orderResponse,errorMessage,orderID];
}
