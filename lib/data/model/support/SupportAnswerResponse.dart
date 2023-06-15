
class SupportAnswerResponse {
  SupportAnswerResponse({
      this.support, 
      this.status,});

  SupportAnswerResponse.fromJson(dynamic json) {
    support = json['support'] != null ? Support.fromJson(json['support']) : null;
    status = json['status'];
  }
  Support? support;
  int? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    final support = this.support;
    if (support != null) {
      map['support'] = support.toJson();
    }
    map['status'] = status;
    return map;
  }

}

class Support {
  Support({
    this.id,
    this.question,
    this.answer,
    this.status,
    this.cityId,});

  Support.fromJson(dynamic json) {
    id = json['id'];
    question = json['question'];
    answer = json['answer'];
    status = json['status'];
    cityId = json['city_id'];
  }
  int? id;
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