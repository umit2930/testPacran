import 'package:dio/dio.dart';
import 'package:dobareh_bloc/utils/dependency_injection.dart';
import 'package:get/instance_manager.dart';

import '../../../../utils/strings.dart';
import '../interceptor.dart';

class UserApiProvider {
  final Dio _dio = Dio();

  final String userToken;

  UserApiProvider() : userToken = Get.find(tag: userTokenTag) {
    _dio.options.headers["Authorization"] = "Bearer $userToken";
    _dio.options.baseUrl = apiBaseURL;
    // _dio.interceptors.add(CustomInterceptors());
  }

  Future<Response> getHome() {
    return _dio.get("home");
  }

  Future<Response> getProfile() {
    return _dio.get("profile");
  }

  Future<Response> getNotifications() {
    return _dio.get("notification");
  }

  ///report
  Future<Response> getReports() {
    return _dio.get("/report/index");
  }

  Future<Response> sendReport(int reportID) {
    return _dio.post("/report/send-report/$reportID");
  }

  ///support
  Future<Response> getSupport()  {
    return  _dio.get("/support/index");
  }

  Future<Response> getSupportAnswer(int supportID)  {
    return  _dio.get("/support/show/$supportID");
  }
}
