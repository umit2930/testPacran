/// today : {"date":"1402-02-19","persian_day_of_week":"سه شنبه","day_of_month_in_jalali":"19","persian_month":"اردیبهشت"}
/// today_orders_count : 1
/// today_delivered_count : 0
/// times : ["9","11","13","15","17"]
/// orders : [{"id":178,"delivery_person_number":"09033093041","delivery_person_name":"شاهین داداش پور","tracking_code":"DB-395573205","status":"waiting","approx_price":"640500","final_price":null,"address":{"address":"تبریز-ولیعصر- بالاتر از پرویس اعتصامی -نرسیده به برج بلور","plaque":"24 شرقی","unit":"A5","latitude":"21.547","longitude":"42.346"},"user_id":"19","delivery_date":"2023-05-09","delivery_time":{"from":11,"to":13},"warehouse_delivery":null,"success_delivered":"0","recalculate_request":"0","city_id":"5","created_at":"2023-05-09T10:21:49.000000Z","updated_at":"2023-05-09T10:21:49.000000Z"}]
/// user : {"id":19,"mobile":"09033093041","verify_code":"37557","first_name":"حسین","last_name":"زرعی","plate_number":{"first":"12","letter":"الف","second":"123","state":"12"},"car_name":"pride","car_color":"sefid","national_code":"1720230609","landline_number":{"code":"123","number":"12312312"},"shaba_number":null,"email":null,"verify_code_expire":"2023-05-09 13:42:58","verify_code_resend":"2023-05-09 13:41:28","image":"https://panel.rasahr.ir/uploads/drivers/profile/profile-820421683205784.webp","status":"1","city_id":"5","last_location":null,"full_name":"حسین زرعی"}
/// way_warehouse : false

class HomeResponse {
  HomeResponse({
      this.today, 
      this.todayOrdersCount, 
      this.todayDeliveredCount, 
      this.times, 
      this.orders, 
      this.user, 
      this.wayWarehouse,});

  HomeResponse.fromJson(dynamic json) {
    today = json['today'] != null ? Today.fromJson(json['today']) : null;
    todayOrdersCount = json['today_orders_count'];
    todayDeliveredCount = json['today_delivered_count'];
    times = json['times'] != null ? json['times'].cast<String>() : [];
    if (json['orders'] != null) {
      orders = [];
      json['orders'].forEach((v) {
        orders?.add(Orders.fromJson(v));
      });
    }
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    wayWarehouse = json['way_warehouse'];
  }
  Today? today;
  num? todayOrdersCount;
  num? todayDeliveredCount;
  List<String>? times;
  List<Orders>? orders;
  User? user;
  bool? wayWarehouse;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (today != null) {
      map['today'] = today?.toJson();
    }
    map['today_orders_count'] = todayOrdersCount;
    map['today_delivered_count'] = todayDeliveredCount;
    map['times'] = times;
    if (orders != null) {
      map['orders'] = orders?.map((v) => v.toJson()).toList();
    }
    if (user != null) {
      map['user'] = user?.toJson();
    }
    map['way_warehouse'] = wayWarehouse;
    return map;
  }

}

/// id : 19
/// mobile : "09033093041"
/// verify_code : "37557"
/// first_name : "حسین"
/// last_name : "زرعی"
/// plate_number : {"first":"12","letter":"الف","second":"123","state":"12"}
/// car_name : "pride"
/// car_color : "sefid"
/// national_code : "1720230609"
/// landline_number : {"code":"123","number":"12312312"}
/// shaba_number : null
/// email : null
/// verify_code_expire : "2023-05-09 13:42:58"
/// verify_code_resend : "2023-05-09 13:41:28"
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

/// id : 178
/// delivery_person_number : "09033093041"
/// delivery_person_name : "شاهین داداش پور"
/// tracking_code : "DB-395573205"
/// status : "waiting"
/// approx_price : "640500"
/// final_price : null
/// address : {"address":"تبریز-ولیعصر- بالاتر از پرویس اعتصامی -نرسیده به برج بلور","plaque":"24 شرقی","unit":"A5","latitude":"21.547","longitude":"42.346"}
/// user_id : "19"
/// delivery_date : "2023-05-09"
/// delivery_time : {"from":11,"to":13}
/// warehouse_delivery : null
/// success_delivered : "0"
/// recalculate_request : "0"
/// city_id : "5"
/// created_at : "2023-05-09T10:21:49.000000Z"
/// updated_at : "2023-05-09T10:21:49.000000Z"

class Orders {
  Orders({
      this.id, 
      this.deliveryPersonNumber, 
      this.deliveryPersonName, 
      this.trackingCode, 
      this.status, 
      this.approxPrice, 
      this.finalPrice, 
      this.address, 
      this.userId, 
      this.deliveryDate, 
      this.deliveryTime, 
      this.warehouseDelivery, 
      this.successDelivered, 
      this.recalculateRequest, 
      this.cityId, 
      this.createdAt, 
      this.updatedAt,});

  Orders.fromJson(dynamic json) {
    id = json['id'];
    deliveryPersonNumber = json['delivery_person_number'];
    deliveryPersonName = json['delivery_person_name'];
    trackingCode = json['tracking_code'];
    status = json['status'];
    approxPrice = json['approx_price'];
    finalPrice = json['final_price'];
    address = json['address'] != null ? Address.fromJson(json['address']) : null;
    userId = json['user_id'];
    deliveryDate = json['delivery_date'];
    deliveryTime = json['delivery_time'] != null ? DeliveryTime.fromJson(json['delivery_time']) : null;
    warehouseDelivery = json['warehouse_delivery'];
    successDelivered = json['success_delivered'];
    recalculateRequest = json['recalculate_request'];
    cityId = json['city_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  num? id;
  String? deliveryPersonNumber;
  String? deliveryPersonName;
  String? trackingCode;
  String? status;
  String? approxPrice;
  dynamic finalPrice;
  Address? address;
  String? userId;
  String? deliveryDate;
  DeliveryTime? deliveryTime;
  dynamic warehouseDelivery;
  String? successDelivered;
  String? recalculateRequest;
  String? cityId;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['delivery_person_number'] = deliveryPersonNumber;
    map['delivery_person_name'] = deliveryPersonName;
    map['tracking_code'] = trackingCode;
    map['status'] = status;
    map['approx_price'] = approxPrice;
    map['final_price'] = finalPrice;
    if (address != null) {
      map['address'] = address?.toJson();
    }
    map['user_id'] = userId;
    map['delivery_date'] = deliveryDate;
    if (deliveryTime != null) {
      map['delivery_time'] = deliveryTime?.toJson();
    }
    map['warehouse_delivery'] = warehouseDelivery;
    map['success_delivered'] = successDelivered;
    map['recalculate_request'] = recalculateRequest;
    map['city_id'] = cityId;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}

/// from : 11
/// to : 13

class DeliveryTime {
  DeliveryTime({
      this.from, 
      this.to,});

  DeliveryTime.fromJson(dynamic json) {
    from = json['from'];
    to = json['to'];
  }
  num? from;
  num? to;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['from'] = from;
    map['to'] = to;
    return map;
  }

}

/// address : "تبریز-ولیعصر- بالاتر از پرویس اعتصامی -نرسیده به برج بلور"
/// plaque : "24 شرقی"
/// unit : "A5"
/// latitude : "21.547"
/// longitude : "42.346"

class Address {
  Address({
      this.address, 
      this.plaque, 
      this.unit, 
      this.latitude, 
      this.longitude,});

  Address.fromJson(dynamic json) {
    address = json['address'];
    plaque = json['plaque'];
    unit = json['unit'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }
  String? address;
  String? plaque;
  String? unit;
  String? latitude;
  String? longitude;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['address'] = address;
    map['plaque'] = plaque;
    map['unit'] = unit;
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    return map;
  }

}

/// date : "1402-02-19"
/// persian_day_of_week : "سه شنبه"
/// day_of_month_in_jalali : "19"
/// persian_month : "اردیبهشت"

class Today {
  Today({
      this.date, 
      this.persianDayOfWeek, 
      this.dayOfMonthInJalali, 
      this.persianMonth,});

  Today.fromJson(dynamic json) {
    date = json['date'];
    persianDayOfWeek = json['persian_day_of_week'];
    dayOfMonthInJalali = json['day_of_month_in_jalali'];
    persianMonth = json['persian_month'];
  }
  String? date;
  String? persianDayOfWeek;
  String? dayOfMonthInJalali;
  String? persianMonth;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['date'] = date;
    map['persian_day_of_week'] = persianDayOfWeek;
    map['day_of_month_in_jalali'] = dayOfMonthInJalali;
    map['persian_month'] = persianMonth;
    return map;
  }

}