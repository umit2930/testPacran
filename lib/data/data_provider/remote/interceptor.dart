import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class CustomInterceptors extends Interceptor {
  Logger logger = Logger();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    logger.i(
        "REQUEST[${options.method}] \n \n PATH => ${options.path} \n \n Auth Token => ${options.headers["Authorization"]} \n \n Data => ${options.data.toString()}");
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.i(
        "RESPONSE[${response.statusCode}] \n \n PATH => ${response.requestOptions.path}");

    //TODO change for show data
    logger.i(response.data);
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    logger.e(
        "ERROR[${err.response?.statusCode}] \n \n PATH => ${err.requestOptions.path} \n \n Data => ${err.response?.data}",
        err);
    super.onError(err, handler);
  }
}
