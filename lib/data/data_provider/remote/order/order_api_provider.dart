import 'package:dio/dio.dart';
import 'package:dobareh_bloc/data/data_provider/remote/interceptor.dart';
import 'package:dobareh_bloc/utils/dependency_injection.dart';
import 'package:dobareh_bloc/utils/strings.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';

class OrderApiProvider {
  final Dio _dio = Dio();

  final String _userToken;

  OrderApiProvider() :_userToken = Get.find(tag: userTokenTag) {
    _dio.options.baseUrl = apiBaseURL;
    _dio.options.headers["Authorization"] = "Bearer $_userToken";
    _dio.interceptors.add(CustomInterceptors());
  }

  Future<Response> getOrderDetails(int orderID) {
    return _dio.get("order/show/$orderID");
  }

}
