enum OrderStatus {
  waiting("waiting"),
  onWay("on_way"),
  inLocation("in_location"),
  rejected("rejected"),

  //TODO must don't show in home
  checkFactor("check_factor"),
  delivered("delivered");

  const OrderStatus(this.value);

  factory OrderStatus.fromString(String status) {
    return values.firstWhere((instance) => instance.value == status);
  }

  final String value;
}

enum OrderStatusChangeReason {
  userNotPresent("user_not_present"),
  disagreement("disagreement"),
  problemInWay("problem_in_way");

  const OrderStatusChangeReason(this.value);

  factory OrderStatusChangeReason.fromString(String status) {
    return values.firstWhere((instance) => instance.value == status);
  }

  final String value;
}

enum DeliveredType { delivered, canceled, all }
