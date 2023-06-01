/// errors : ["تلفن همراه یک فرمت معتبر نیست"]
/// status : 400

class ErrorModel {
  ErrorModel({
    List<String>? errors,
    num? status,
  }) {
    _errors = errors;
    _status = status;
  }

  ErrorModel.fromJson(dynamic json) {
    _errors = json['errors'] != null ? json['errors'].cast<String>() : [];
    _status = json['status'];
  }

  List<String>? _errors;
  num? _status;

  ErrorModel copyWith({
    List<String>? errors,
    num? status,
  }) =>
      ErrorModel(
        errors: errors ?? _errors,
        status: status ?? _status,
      );

  List<String>? get errors => _errors;

  num? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['errors'] = _errors;
    map['status'] = _status;
    return map;
  }
}
