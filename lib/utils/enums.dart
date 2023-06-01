enum OrderStatus {
  waiting("waiting"),
  on_way("on_way"),
  in_location("in_location"),
  rejected("rejected"),

  //TODO must don't show in home
  check_factor("check_factor"),
  delivered("delivered");

  const OrderStatus(this.value);

  factory OrderStatus.fromString(String status) {
    return values.firstWhere((instance) => instance.value == status);
  }

  final String value;
}

enum OrderStatusChangeReason {
  user_not_present("user_not_present"),
  disagreement("disagreement"),
  problem_in_way("problem_in_way");

  const OrderStatusChangeReason(this.value);

  factory OrderStatusChangeReason.fromString(String status) {
    return values.firstWhere((instance) => instance.value == status);
  }

  final String value;
}

enum DeliveredType { delivered, canceled, all }

/*
enum ProfileKey{
  first_name,
  last_name,
  national_code,
  shaba_number,
}
*/
