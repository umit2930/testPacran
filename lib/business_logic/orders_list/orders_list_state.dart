part of 'orders_list_cubit.dart';

enum WaitingOrdersStatus { initial, loading, success, failure }

enum DeliveredOrdersStatus { initial, loading, success, failure }

class OrdersListState extends Equatable {
  final WaitingOrdersStatus waitingOrdersStatus;
  final DeliveredOrdersStatus deliveredOrdersStatus;

  final OrdersListResponse? waitingOrdersResponse;
  final OrdersListResponse? deliveredOrdersResponse;

  final String? errorMessage;

  final int selectedTab;

  ///waiting tab
  final int selectedTimePackID;
  final Jalali todayDate;
  final Map<DeliveryTime, List<Orders>>? waitingPacks;
  final Orders? inProgressOrder;

  ///delivered tab
  final Jalali selectedDate;
  final List<Orders>? deliveredOrders;



  const OrdersListState(
      {required this.waitingOrdersStatus,
      required this.deliveredOrdersStatus,
      this.waitingOrdersResponse,
      this.deliveredOrdersResponse,
      this.errorMessage,
      this.selectedTab = 0,
      required this.todayDate,
      this.selectedTimePackID = 0,
      this.waitingPacks,
      this.inProgressOrder,
      required this.selectedDate,
      this.deliveredOrders});

  @override
  List<Object?> get props => [
        waitingOrdersStatus,
        deliveredOrdersStatus,
        waitingOrdersResponse,
        deliveredOrdersResponse,
        errorMessage,
        selectedTab,
        todayDate,
        selectedTimePackID,
        waitingPacks,
        inProgressOrder,
        selectedDate,
        deliveredOrders
      ];

  OrdersListState copyWith({
    WaitingOrdersStatus? waitingOrdersStatus,
    DeliveredOrdersStatus? deliveredOrdersStatus,
    OrdersListResponse? waitingOrdersResponse,
    OrdersListResponse? deliveredOrdersResponse,
    String? errorMessage,
    int? selectedTab,
    Jalali? today,
    int? selectedTimePackID,
    Map<DeliveryTime, List<Orders>>? waitingPacks,
    Orders? inProgressOrder,
    Jalali? selectedDate,
    List<Orders>? deliveredOrders,
  }) {
    return OrdersListState(
      waitingOrdersStatus: waitingOrdersStatus ?? this.waitingOrdersStatus,
      deliveredOrdersStatus:
          deliveredOrdersStatus ?? this.deliveredOrdersStatus,
      waitingOrdersResponse:
          waitingOrdersResponse ?? this.waitingOrdersResponse,
      deliveredOrdersResponse:
          deliveredOrdersResponse ?? this.deliveredOrdersResponse,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedTab: selectedTab ?? this.selectedTab,
      todayDate: today ?? this.todayDate,
      selectedTimePackID: selectedTimePackID ?? this.selectedTimePackID,
      waitingPacks: waitingPacks ?? this.waitingPacks,
      inProgressOrder: inProgressOrder ?? this.inProgressOrder,
      selectedDate: selectedDate ?? this.selectedDate,
      deliveredOrders: deliveredOrders ?? this.deliveredOrders,
    );
  }
}
