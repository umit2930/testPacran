/// token : "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vZHJpdmVyLnJhc2Foci5pci9hcGkvdjEvdmVyaWZ5IiwiaWF0IjoxNjgzMjA3ODA2LCJleHAiOjE2ODQ0MDc4MDYsIm5iZiI6MTY4MzIwNzgwNiwianRpIjoianpDUnp5OThSUjdDVnBERSIsInN1YiI6IjE5IiwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.UX40LGttjrYjvGusuaUqwnBDMQdJHiySTA1wHq5doRk"
/// user : {"id":19,"mobile":"09033093041","verify_code":"31439","first_name":"حسین","last_name":"زرعی","plate_number":{"first":"12","letter":"الف","second":"123","state":"12"},"car_name":"pride","car_color":"sefid","national_code":"1720230609","landline_number":{"code":"123","number":"12312312"},"shaba_number":null,"email":null,"verify_code_expire":"2023-05-04 17:16:11","verify_code_resend":"2023-05-04 17:14:41","image":"https://panel.rasahr.ir/uploads/drivers/profile/profile-820421683205784.webp","status":"1","city_id":"5","last_location":null,"full_name":"حسین زرعی"}
/// status : 200

class VerifyResponse {
  VerifyResponse({
      this.token, 
      this.user, 
      this.status,});

  VerifyResponse.fromJson(dynamic json) {
    token = json['token'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    status = json['status'];
  }
  String? token;
  User? user;
  num? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['token'] = token;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    map['status'] = status;
    return map;
  }

}

/// id : 19
/// mobile : "09033093041"
/// verify_code : "31439"
/// first_name : "حسین"
/// last_name : "زرعی"
/// plate_number : {"first":"12","letter":"الف","second":"123","state":"12"}
/// car_name : "pride"
/// car_color : "sefid"
/// national_code : "1720230609"
/// landline_number : {"code":"123","number":"12312312"}
/// shaba_number : null
/// email : null
/// verify_code_expire : "2023-05-04 17:16:11"
/// verify_code_resend : "2023-05-04 17:14:41"
/// image : "https://panel.rasahr.ir/uploads/drivers/profile/profile-820421683205784.webp"
/// status : "1"
/// city_id : "5"
/// last_location : null
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
    lastLocation = json['last_location'];
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
  dynamic lastLocation;
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
    map['last_location'] = lastLocation;
    map['full_name'] = fullName;
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