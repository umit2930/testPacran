import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import '../../../utils/strings.dart';
import '../local/app_shared_preferences.dart';
import 'interceptor.dart';

class ApiProvider{

  final Dio _dio = Dio();

  ApiProvider() {
    AppSharedPreferences appSharedPreferences = AppSharedPreferences();
    String? token = appSharedPreferences.getToken();

    _dio.options.headers["Authorization"] = "Bearer $token";
    _dio.options.baseUrl = apiBaseURL;
    _dio.interceptors.add(CustomInterceptors());
    _dio.interceptors.add(Interceptor());
  }

  ///Auth
  Future<Response> login(String mobileNumber) async {
    Logger().w(mobileNumber);
    final formData = FormData.fromMap({"mobile": mobileNumber});
    return await _dio.post("login", data: formData);
  }

  Future<Response> verify(String mobileNumber, String code) async {
    final formData =
    FormData.fromMap({"mobile": mobileNumber, "verify_code": code});
    return await _dio.post("verify", data: formData);
  }
}