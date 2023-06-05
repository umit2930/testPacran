/// mobile : "09033093041"
/// remaining : 60
/// status : 200

class LoginResponse {
  LoginResponse({
    this.mobile,
    this.remaining,
    this.status,
  });

  LoginResponse.fromJson(dynamic json) {
    mobile = json['mobile'];
    remaining = json['remaining'];
    status = json['status'];
  }

  String? mobile;
  num? remaining;
  num? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['mobile'] = mobile;
    map['remaining'] = remaining;
    map['status'] = status;
    return map;
  }
}
