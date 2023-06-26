/// report : [{"id":1,"question":"مشکل 1","answer":"جواب مشکل 1","status":"1","city_id":"5"}]
/// mobile : "02174391400"
/// message : 200

class ReportResponse {
  ReportResponse({
      this.report, 
      this.mobile, 
      this.message,});

  ReportResponse.fromJson(dynamic json) {
    if (json['report'] != null) {
      report = [];
      json['report'].forEach((v) {
        report?.add(Report.fromJson(v));
      });
    }
    mobile = json['mobile'];
    message = json['message'];
  }
  List<Report>? report;
  String? mobile;
  num? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (report != null) {
      map['report'] = report?.map((v) => v.toJson()).toList();
    }
    map['mobile'] = mobile;
    map['message'] = message;
    return map;
  }

}

/// id : 1
/// question : "مشکل 1"
/// answer : "جواب مشکل 1"
/// status : "1"
/// city_id : "5"

class Report {
  Report({
      this.id, 
      this.question, 
      this.answer, 
      this.status, 
      this.cityId,});

  Report.fromJson(dynamic json) {
    id = json['id'];
    question = json['question'];
    answer = json['answer'];
    status = json['status'];
    cityId = json['city_id'];
  }
  num? id;
  String? question;
  String? answer;
  String? status;
  String? cityId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['question'] = question;
    map['answer'] = answer;
    map['status'] = status;
    map['city_id'] = cityId;
    return map;
  }

}