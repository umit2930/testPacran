/// notification : [{"id":14,"title":"درخواست محاسبه مجدد","body":"پاکران محترم کاربر درخواست محاسبه مجدد مقادیر را دارد. لطفا باری دیگر محاسبه کنید.","location":"/home_screen","status":true,"created_at":"2023-05-16T14:29:56.000000Z","updated_at":"2023-05-23T12:22:37.000000Z","user_id":"19"},{"id":23,"title":"درخواست محاسبه مجدد","body":"پاکران محترم کاربر درخواست محاسبه مجدد مقادیر را دارد. لطفا باری دیگر محاسبه کنید.","location":"/home_screen","status":true,"created_at":"2023-05-25T14:19:35.000000Z","updated_at":"2023-06-15T11:06:56.000000Z","user_id":"19"},{"id":24,"title":"درخواست محاسبه مجدد","body":"پاکران محترم کاربر درخواست محاسبه مجدد مقادیر را دارد. لطفا باری دیگر محاسبه کنید.","location":"/home_screen","status":true,"created_at":"2023-05-28T06:16:34.000000Z","updated_at":"2023-06-15T11:06:56.000000Z","user_id":"19"},{"id":25,"title":"درخواست محاسبه مجدد","body":"پاکران محترم کاربر درخواست محاسبه مجدد مقادیر را دارد. لطفا باری دیگر محاسبه کنید.","location":"/home_screen","status":true,"created_at":"2023-05-28T06:31:20.000000Z","updated_at":"2023-06-15T11:06:56.000000Z","user_id":"19"},{"id":26,"title":"درخواست محاسبه مجدد","body":"پاکران محترم کاربر درخواست محاسبه مجدد مقادیر را دارد. لطفا باری دیگر محاسبه کنید.","location":"/home_screen","status":true,"created_at":"2023-05-29T12:05:10.000000Z","updated_at":"2023-06-15T11:06:56.000000Z","user_id":"19"},{"id":27,"title":"درخواست محاسبه مجدد","body":"پاکران محترم کاربر درخواست محاسبه مجدد مقادیر را دارد. لطفا باری دیگر محاسبه کنید.","location":"/home_screen","status":true,"created_at":"2023-06-08T08:36:06.000000Z","updated_at":"2023-06-15T11:06:56.000000Z","user_id":"19"},{"id":28,"title":"درخواست محاسبه مجدد","body":"پاکران محترم کاربر درخواست محاسبه مجدد مقادیر را دارد. لطفا باری دیگر محاسبه کنید.","location":"/home_screen","status":true,"created_at":"2023-06-08T08:37:07.000000Z","updated_at":"2023-06-15T11:06:56.000000Z","user_id":"19"},{"id":29,"title":"درخواست محاسبه مجدد","body":"پاکران محترم کاربر درخواست محاسبه مجدد مقادیر را دارد. لطفا باری دیگر محاسبه کنید.","location":"/home_screen","status":true,"created_at":"2023-06-08T08:42:13.000000Z","updated_at":"2023-06-15T11:06:56.000000Z","user_id":"19"},{"id":30,"title":"درخواست محاسبه مجدد","body":"پاکران محترم کاربر درخواست محاسبه مجدد مقادیر را دارد. لطفا باری دیگر محاسبه کنید.","location":"/home_screen","status":true,"created_at":"2023-06-11T06:16:23.000000Z","updated_at":"2023-06-15T11:06:56.000000Z","user_id":"19"},{"id":32,"title":"درخواست محاسبه مجدد","body":"پاکران محترم کاربر درخواست محاسبه مجدد مقادیر را دارد. لطفا باری دیگر محاسبه کنید.","location":"/home_screen","status":true,"created_at":"2023-06-15T13:54:11.000000Z","updated_at":"2023-06-17T18:58:20.000000Z","user_id":"19"},{"id":33,"title":"درخواست محاسبه مجدد","body":"پاکران محترم کاربر درخواست محاسبه مجدد مقادیر را دارد. لطفا باری دیگر محاسبه کنید.","location":"/home_screen","status":true,"created_at":"2023-06-15T14:02:22.000000Z","updated_at":"2023-06-17T18:58:20.000000Z","user_id":"19"}]
/// status : 200

class NotificationsResponse {
  NotificationsResponse({
      this.notification, 
      this.status,});

  NotificationsResponse.fromJson(dynamic json) {
    if (json['notification'] != null) {
      notification = [];
      json['notification'].forEach((v) {
        notification?.add(Notification.fromJson(v));
      });
    }
    status = json['status'];
  }
  List<Notification>? notification;
  num? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (notification != null) {
      map['notification'] = notification?.map((v) => v.toJson()).toList();
    }
    map['status'] = status;
    return map;
  }

}

/// id : 14
/// title : "درخواست محاسبه مجدد"
/// body : "پاکران محترم کاربر درخواست محاسبه مجدد مقادیر را دارد. لطفا باری دیگر محاسبه کنید."
/// location : "/home_screen"
/// status : true
/// created_at : "2023-05-16T14:29:56.000000Z"
/// updated_at : "2023-05-23T12:22:37.000000Z"
/// user_id : "19"

class Notification {
  Notification({
      this.id, 
      this.title, 
      this.body, 
      this.location, 
      this.status, 
      this.createdAt, 
      this.updatedAt, 
      this.userId,});

  Notification.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    body = json['body'];
    location = json['location'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userId = json['user_id'];
  }
  num? id;
  String? title;
  String? body;
  String? location;
  bool? status;
  String? createdAt;
  String? updatedAt;
  String? userId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['body'] = body;
    map['location'] = location;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['user_id'] = userId;
    return map;
  }

}