import 'package:dio/dio.dart';

import '../../../../utils/strings.dart';
import '../interceptor.dart';

class AuthApiProvider {
  final Dio _dio = Dio();

  AuthApiProvider() {
    _dio.options.baseUrl = apiBaseURL;
    _dio.interceptors.add(CustomInterceptors());
  }

  Future<Response> login(String mobileNumber)  {
    final formData = FormData.fromMap({"mobile": mobileNumber});
    return _dio.post("login", data: formData);
  }

  Future<Response> verify(String mobileNumber, String code)  {
    final formData =
        FormData.fromMap({"mobile": mobileNumber, "verify_code": code});
    return  _dio.post("verify", data: formData);
  }
}
