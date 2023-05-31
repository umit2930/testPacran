import 'package:dio/dio.dart';

import '../../../../utils/strings.dart';
import '../interceptor.dart';

class HomeApiProvider {
  final Dio _dio = Dio();

  HomeApiProvider(String token) {
    _dio.options.headers["Authorization"] = "Bearer $token";
    _dio.options.baseUrl = apiBaseURL;
    _dio.interceptors.add(CustomInterceptors());
  }


  Future<Response> getHome() async {
    return await _dio.get("home");
  }

}
