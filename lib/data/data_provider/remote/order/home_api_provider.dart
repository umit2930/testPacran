import 'package:dio/dio.dart';
import 'package:dobareh_bloc/utils/dependency_injection.dart';
import 'package:get/instance_manager.dart';

import '../../../../utils/strings.dart';

class HomeApiProvider {
  final Dio _dio = Dio();

  final String userToken;

  HomeApiProvider() : userToken = Get.find(tag: userTokenTag) {
    _dio.options.headers["Authorization"] = "Bearer $userToken";
    _dio.options.baseUrl = apiBaseURL;
    // _dio.interceptors.add(CustomInterceptors());
  }

  Future<Response> getHome() async {
    return await _dio.get("home");
  }
}
