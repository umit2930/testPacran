import 'package:dobareh_bloc/data/data_provider/remote/order/order_api_provider.dart';
import 'package:dobareh_bloc/data/model/order/order_response.dart';
import 'package:dobareh_bloc/data/model/success_model.dart';
import 'package:dobareh_bloc/utils/network_response_to_result.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';

import '../../utils/enums.dart';

class OrderRepository {
  final OrderApiProvider _orderApiProvider;

  OrderRepository() : _orderApiProvider = Get.find();

  Future<OrderResponse> getDetails(int orderID) {
    return NetworkResponseToResult<OrderResponse>().generalNetworkResult(
        OrderResponse.fromJson, _orderApiProvider.getDetails(orderID));
  }

  Future<SuccessModel> changeStatus(
      {required int orderID,
      required OrderStatus orderStatus,
      OrderStatusChangeReason? changeReason}) {
    return NetworkResponseToResult<SuccessModel>().generalNetworkResult(
        SuccessModel.fromJson,
        _orderApiProvider.changeStatus(
            orderID: orderID,
            orderStatus: orderStatus,
            changeReason: changeReason));
  }
}
