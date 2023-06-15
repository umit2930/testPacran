/// report : {"id":2,"question":"مشکل 2","answer":"جواب مشکل 2","status":"0","city_id":"5"}
/// user : {"id":19,"mobile":"09033093041","verify_code":"59025","first_name":"حسین","last_name":"زرعی","plate_number":{"first":"12","letter":"الف","second":"123","state":"12"},"car_name":"pride","car_color":"sefid","national_code":"1720230609","landline_number":{"code":"123","number":"12312312"},"shaba_number":null,"email":null,"verify_code_expire":"2023-05-23 13:17:43","verify_code_resend":"2023-05-23 13:16:13","image":"https://panel.rasahr.ir/uploads/drivers/profile/profile-820421683205784.webp","status":"1","city_id":"5","last_location":{"latitude":"38.2521993","longitude":"48.3084135"},"full_name":"حسین زرعی"}
/// status : 200

class SendReportResponse {
  SendReportResponse({
      this.report, 
      this.user, 
      this.status,});

  SendReportResponse.fromJson(dynamic json) {
    report = json['report'] != null ? Report.fromJson(json['report']) : null;
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    status = json['status'];
  }
  Report? report;
  User? user;
  num? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (report != null) {
      map['report'] = report?.toJson();
    }
    if (user != null) {
      map['user'] = user?.toJson();
    }
    map['status'] = status;
    return map;
  }

}

/// id : 19
/// mobile : "09033093041"
/// verify_code : "59025"
/// first_name : "حسین"
/// last_name : "زرعی"
/// plate_number : {"first":"12","letter":"الف","second":"123","state":"12"}
/// car_name : "pride"
/// car_color : "sefid"
/// national_code : "1720230609"
/// landline_number : {"code":"123","number":"12312312"}
/// shaba_number : null
/// email : null
/// verify_code_expire : "2023-05-23 13:17:43"
/// verify_code_resend : "2023-05-23 13:16:13"
/// image : "https://panel.rasahr.ir/uploads/drivers/profile/profile-820421683205784.webp"
/// status : "1"
/// city_id : "5"
/// last_location : {"latitude":"38.2521993","longitude":"48.3084135"}
/// full_name : "حسین زرعی"

class User {
  User({
      this.id, 
      this.mobile, 
      this.verifyCode, 
      this.firstName, 
      this.lastName, 
      this.plateNumber, 
      this.carName, 
      this.carColor, 
      this.nationalCode, 
      this.landlineNumber, 
      this.shabaNumber, 
      this.email, 
      this.verifyCodeExpire, 
      this.verifyCodeResend, 
      this.image, 
      this.status, 
      this.cityId, 
      this.lastLocation, 
      this.fullName,});

  User.fromJson(dynamic json) {
    id = json['id'];
    mobile = json['mobile'];
    verifyCode = json['verify_code'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    plateNumber = json['plate_number'] != null ? PlateNumber.fromJson(json['plate_number']) : null;
    carName = json['car_name'];
    carColor = json['car_color'];
    nationalCode = json['national_code'];
    landlineNumber = json['landline_number'] != null ? LandlineNumber.fromJson(json['landline_number']) : null;
    shabaNumber = json['shaba_number'];
    email = json['email'];
    verifyCodeExpire = json['verify_code_expire'];
    verifyCodeResend = json['verify_code_resend'];
    image = json['image'];
    status = json['status'];
    cityId = json['city_id'];
    lastLocation = json['last_location'] != null ? LastLocation.fromJson(json['last_location']) : null;
    fullName = json['full_name'];
  }
  num? id;
  String? mobile;
  String? verifyCode;
  String? firstName;
  String? lastName;
  PlateNumber? plateNumber;
  String? carName;
  String? carColor;
  String? nationalCode;
  LandlineNumber? landlineNumber;
  dynamic shabaNumber;
  dynamic email;
  String? verifyCodeExpire;
  String? verifyCodeResend;
  String? image;
  String? status;
  String? cityId;
  LastLocation? lastLocation;
  String? fullName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['mobile'] = mobile;
    map['verify_code'] = verifyCode;
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    if (plateNumber != null) {
      map['plate_number'] = plateNumber?.toJson();
    }
    map['car_name'] = carName;
    map['car_color'] = carColor;
    map['national_code'] = nationalCode;
    if (landlineNumber != null) {
      map['landline_number'] = landlineNumber?.toJson();
    }
    map['shaba_number'] = shabaNumber;
    map['email'] = email;
    map['verify_code_expire'] = verifyCodeExpire;
    map['verify_code_resend'] = verifyCodeResend;
    map['image'] = image;
    map['status'] = status;
    map['city_id'] = cityId;
    if (lastLocation != null) {
      map['last_location'] = lastLocation?.toJson();
    }
    map['full_name'] = fullName;
    return map;
  }

}

/// latitude : "38.2521993"
/// longitude : "48.3084135"

class LastLocation {
  LastLocation({
      this.latitude, 
      this.longitude,});

  LastLocation.fromJson(dynamic json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
  }
  String? latitude;
  String? longitude;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    return map;
  }

}

/// code : "123"
/// number : "12312312"

class LandlineNumber {
  LandlineNumber({
      this.code, 
      this.number,});

  LandlineNumber.fromJson(dynamic json) {
    code = json['code'];
    number = json['number'];
  }
  String? code;
  String? number;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['number'] = number;
    return map;
  }

}

/// first : "12"
/// letter : "الف"
/// second : "123"
/// state : "12"

class PlateNumber {
  PlateNumber({
      this.first, 
      this.letter, 
      this.second, 
      this.state,});

  PlateNumber.fromJson(dynamic json) {
    first = json['first'];
    letter = json['letter'];
    second = json['second'];
    state = json['state'];
  }
  String? first;
  String? letter;
  String? second;
  String? state;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['first'] = first;
    map['letter'] = letter;
    map['second'] = second;
    map['state'] = state;
    return map;
  }

}

/// id : 2
/// question : "مشکل 2"
/// answer : "جواب مشکل 2"
/// status : "0"
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