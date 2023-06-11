import 'dart:convert';

import 'package:dobareh_bloc/data/data_provider/remote/order/order_api_provider.dart';
import 'package:dobareh_bloc/data/model/calculate_values/CalculateValuesBody.dart';
import 'package:dobareh_bloc/data/model/calculate_values/CategoriesResponse.dart'
    as categories_response;
import 'package:dobareh_bloc/data/model/calculate_values/OrederStatusResponse.dart';
import 'package:dobareh_bloc/data/model/order/orders_list_response.dart';
import 'package:dobareh_bloc/data/model/success_model.dart';
import 'package:dobareh_bloc/utils/network_response_to_result.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:logger/logger.dart';

import '../../utils/enums.dart';
import '../model/calculate_values/CategoriesResponse.dart';
import '../model/order/order_response.dart';

class OrderRepository {
  final OrderApiProvider _orderApiProvider;

  OrderRepository() : _orderApiProvider = Get.find();

  ///orders
  Future<OrdersListResponse> getOrders(
      {OrderStatus? orderStatus, String? date, int? limit, int? offset}) {
    return NetworkResponseToResult<OrdersListResponse>().generalNetworkResult(
        OrdersListResponse.fromJson,
        _orderApiProvider.getOrders(
            orderStatus: orderStatus,
            date: date,
            limit: limit,
            offset: offset));
  }

  ///details
  Future<OrderResponse> getDetails(int orderID) {
    return NetworkResponseToResult<OrderResponse>().generalNetworkResult(
        OrderResponse.fromJson, _orderApiProvider.getDetails(orderID));
  }

  ///status
  Future<SuccessModel> changeStatus(
      {required int orderID,
      required OrderStatus orderStatus,
      OrderStatusChangeReason? changeReason}) {
    Map<String, dynamic> dataMap = {
      "status": orderStatus.value,
      if (changeReason != null) ...{"reason": changeReason.value}
    };

    return NetworkResponseToResult<SuccessModel>().generalNetworkResult(
        SuccessModel.fromJson,
        _orderApiProvider.postStatus(orderID: orderID, data: dataMap));
  }

  Future<OrderStatusResponse> checkStatus({required int orderID}) {
    return NetworkResponseToResult<OrderStatusResponse>().generalNetworkResult(
        OrderStatusResponse.fromJson,
        _orderApiProvider.getStatus(orderID: orderID));
  }

  ///values
  Future<CategoriesResponse> getCategories() {
    return NetworkResponseToResult<CategoriesResponse>().generalNetworkResult(
        CategoriesResponse.fromJson, _orderApiProvider.getCategories());
  }

  Future<SuccessModel> calculateValues(
      int orderID, Map<categories_response.MaterialCategories, Items> values) {
    //convert values to body
    Map<String, dynamic> valuesBody =
        CalculateValuesBody(items: values.values.toList()).toJson();

    Logger().e(jsonEncode(valuesBody));

    return NetworkResponseToResult<SuccessModel>().generalNetworkResult(
        SuccessModel.fromJson,
        _orderApiProvider.postValues(orderID, valuesBody));
  }
}
