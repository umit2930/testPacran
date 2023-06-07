class OrderStatusResponse {
  OrderStatusResponse({
      this.orderStatus, 
      this.status,});

  OrderStatusResponse.fromJson(dynamic json) {
    orderStatus = json['order_status'];
    status = json['status'];
  }
  int? orderStatus;
  int? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['order_status'] = orderStatus;
    map['status'] = status;
    return map;
  }

}