import 'package:dio/dio.dart';

import '../../../../utils/strings.dart';
import '../interceptor.dart';

class AuthApiProvider {
  final Dio _dio = Dio();

  AuthApiProvider() {
    _dio.options.baseUrl = apiBaseURL;
    _dio.interceptors.add(CustomInterceptors());
  }

  Future<Response> login(String mobileNumber) async {
    final formData = FormData.fromMap({"mobile": mobileNumber});
    return await _dio.post("login", data: formData);
  }

  Future<Response> verify(String mobileNumber, String code) async {
    final formData =
        FormData.fromMap({"mobile": mobileNumber, "verify_code": code});
    return await _dio.post("verify", data: formData);
  }
}
