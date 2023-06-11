part of 'orders_list_cubit.dart';


Map<DeliveryTime, List<Orders>> extractTimePacks(OrdersListResponse? model) {
  // inProgressOrder =null;
  Map<DeliveryTime, List<Orders>> timePacks = {};
  if (model != null) {
    ///Extract times
    for (int i = 0; i < model.times!.length - 1; i++) {
      var deliver = DeliveryTime(
          from: num.parse(model.times![i]),
          to: num.parse(model.times![(i + 1)]));
      timePacks[deliver] = [];
    }

    ///put orders on times
    for (var order in model.orders!) {
      for (var time in timePacks.keys) {
        if (time.from == order.deliveryTime!.from &&
            time.to == order.deliveryTime!.to) {
          timePacks[time]?.add(order);

          if (order.status == OrderStatus.onWay.value ||
              order.status == OrderStatus.inLocation.value ||
              order.status == OrderStatus.checkFactor.value) {
            // inProgressOrder = order;
          }
        }
      }
    }
  }
  return timePacks;
}

Orders? getInProgressOrder(OrdersListResponse? model) {
  for (var order in model!.orders!) {
    if (order.status == OrderStatus.onWay.value ||
        order.status == OrderStatus.inLocation.value ||
        order.status == OrderStatus.checkFactor.value) {
      return order;
    }
  }
  return null;
}