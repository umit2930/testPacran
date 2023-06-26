
import 'package:dobareh_bloc/data/data_provider/remote/order/order_api_provider.dart';
import 'package:dobareh_bloc/data/model/calculate_values/calculate_values_body.dart';
import 'package:dobareh_bloc/data/model/calculate_values/categories_response.dart'
    as categories_response;
import 'package:dobareh_bloc/data/model/calculate_values/oreder_status_response.dart';
import 'package:dobareh_bloc/data/model/order/orders_list_response.dart';
import 'package:dobareh_bloc/data/model/success_model.dart';
import 'package:dobareh_bloc/utils/network_response_to_result.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';

import '../../utils/enums.dart';
import '../model/calculate_values/categories_response.dart';
import '../model/order/order_response.dart';

class OrderRepository {
  final OrderApiProvider _orderApiProvider;

  OrderRepository() : _orderApiProvider = Get.find();

  ///orders
  Future<OrdersListResponse> getOrders(
      {OrderStatus? orderStatus, String? date, int? limit, int? offset}) {
    return generalNetworkResult<OrdersListResponse>(
        OrdersListResponse.fromJson,
        _orderApiProvider.getOrders(
            orderStatus: orderStatus,
            date: date,
            limit: limit,
            offset: offset));
  }

  ///details
  Future<OrderResponse> getDetails(int orderID) {
    return generalNetworkResult<OrderResponse>(
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

    return generalNetworkResult<SuccessModel>(
        SuccessModel.fromJson,
        _orderApiProvider.postStatus(orderID: orderID, data: dataMap));
  }

  Future<OrderStatusResponse> checkStatus({required int orderID}) {
    return generalNetworkResult<OrderStatusResponse>(
        OrderStatusResponse.fromJson,
        _orderApiProvider.getStatus(orderID: orderID));
  }

  ///values
  Future<CategoriesResponse> getCategories() {
    return generalNetworkResult<CategoriesResponse>(
        CategoriesResponse.fromJson, _orderApiProvider.getCategories());
  }

  Future<SuccessModel> calculateValues(
      int orderID, Map<categories_response.MaterialCategories, Items> values) {
    //convert values to body
    Map<String, dynamic> valuesBody =
        CalculateValuesBody(items: values.values.toList()).toJson();


    return generalNetworkResult<SuccessModel>(
        SuccessModel.fromJson,
        _orderApiProvider.postValues(orderID, valuesBody));
  }
}
