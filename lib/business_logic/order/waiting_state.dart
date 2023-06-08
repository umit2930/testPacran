part of 'waiting_cubit.dart';

enum OrderStatusStatus { init, loading, success, error }

class WaitingState extends Equatable {
  final OrderStatusStatus orderStatusStatus;
  final OrderStatusResponse? orderStatusResponse;

  final String? errorMessage;

  final int orderID;

  const WaitingState(
      {required this.orderStatusStatus,
      this.orderStatusResponse,
      this.errorMessage,
      required this.orderID});

  @override
  List<Object?> get props =>
      [orderStatusStatus, orderStatusResponse, errorMessage, orderID];

  WaitingState copyWith({
    OrderStatusStatus? orderStatusStatus,
    OrderStatusResponse? orderStatusResponse,
    String? errorMessage,
    int? orderID,
  }) {
    return WaitingState(
      orderStatusStatus: orderStatusStatus ?? this.orderStatusStatus,
      orderStatusResponse: orderStatusResponse ?? this.orderStatusResponse,
      errorMessage: errorMessage ?? this.errorMessage,
      orderID: orderID ?? this.orderID,
    );
  }
}
