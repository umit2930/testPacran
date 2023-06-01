class SuccessModel {
  SuccessModel({
    this.status,
  });

  SuccessModel.fromJson(dynamic json) {
    status = json['status'];
  }

  int? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    return map;
  }
}
