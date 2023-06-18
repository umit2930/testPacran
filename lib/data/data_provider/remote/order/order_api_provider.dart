import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dobareh_bloc/utils/dependency_injection.dart';
import 'package:dobareh_bloc/utils/strings.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';

import '../../../../utils/enums.dart';
import '../interceptor.dart';

class OrderApiProvider {
  final Dio _dio = Dio();

  final String _userToken;

  OrderApiProvider() : _userToken = Get.find(tag: userTokenTag) {
    _dio.options.baseUrl = apiBaseURL;
    _dio.options.headers["Authorization"] = "Bearer $_userToken";
    _dio.interceptors.add(CustomInterceptors());
  }

  Future<Response> getDetails(int orderID) {
    return _dio.get("order/show/$orderID");
  }

  Future<Response> getOrders(
      {OrderStatus? orderStatus, String? date, int? limit, int? offset}) async {
    Map<String ,String> queries = {};

    if(orderStatus != null) {
      queries["status"] = orderStatus.value;
    }
    if(date != null) {
      queries["date"] = date;
    }

    if(limit != null) {
      queries["limit"] = "$limit";
    }
    if(offset != null) {
      queries["offset"] = "$offset";
    }


    return await _dio.get("order/", queryParameters:queries);
  }

  Future<Response> postStatus(
      {required int orderID, required Map<String, dynamic> data}) {

    var formData = FormData.fromMap(data);

    return _dio.post("order/change-status/$orderID", data: formData);
  }

  Future<Response> getStatus({required int orderID}) {
    return _dio.get("order/check-status/$orderID");
  }

  Future<Response> getCategories() {
    return _dio.get("/order/material-categories");
  }

  Future<Response> postValues(int orderID, Map<String, dynamic> values) {
    return _dio.post("/order/calculate/$orderID", data: json.encode(values));
  }
}
