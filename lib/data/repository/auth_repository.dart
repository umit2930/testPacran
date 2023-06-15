import 'package:dobareh_bloc/data/data_provider/local/auth_shared_preferences.dart';
import 'package:dobareh_bloc/data/data_provider/remote/auth/auth_api_provider.dart';
import 'package:dobareh_bloc/utils/network_response_to_result.dart';
import 'package:get/get.dart';

import '../model/auth/login_response.dart';
import '../model/auth/verify_response.dart';

class AuthRepository {
  final AuthApiProvider _apiProvider;
  final AuthSharedPreferences _appSharedPreferences;

  AuthRepository()
      : _apiProvider = Get.find(),
        _appSharedPreferences = Get.find();

  Future<LoginResponse> login(String number) async {
    return await generalNetworkResult<LoginResponse>(
        LoginResponse.fromJson, _apiProvider.login(number));
  }

  Future<VerifyResponse> verify(String number, String code) async {
    return await generalNetworkResult<VerifyResponse>(
        VerifyResponse.fromJson, _apiProvider.verify(number, code));
  }

  Future<bool> saveToken(String token) async {
    return await _appSharedPreferences.saveToken(token);
  }

  Future<String?> getToken() async {
    var token = await _appSharedPreferences.getToken();
    return token;
  }

  Future<bool> removeToken() async {
    var isRemoved = await _appSharedPreferences.removeToken();
    return isRemoved;
  }
}
