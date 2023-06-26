/// supports : [{"id":1,"question":"سوال 1"},{"id":2,"question":"سوال 2"},{"id":3,"question":"سوال 3"}]
/// number : "02174391400"
/// status : 200

class SupportResponse {
  SupportResponse({
      this.supports, 
      this.number, 
      this.status,});

  SupportResponse.fromJson(dynamic json) {
    if (json['supports'] != null) {
      supports = [];
      json['supports'].forEach((v) {
        supports?.add(Supports.fromJson(v));
      });
    }
    number = json['number'];
    status = json['status'];
  }
  List<Supports>? supports;
  String? number;
  num? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (supports != null) {
      map['supports'] = supports?.map((v) => v.toJson()).toList();
    }
    map['number'] = number;
    map['status'] = status;
    return map;
  }

}

/// id : 1
/// question : "سوال 1"

class Supports {
  Supports({
      this.id, 
      this.question,});

  Supports.fromJson(dynamic json) {
    id = json['id'];
    question = json['question'];
  }
  num? id;
  String? question;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['question'] = question;
    return map;
  }

}