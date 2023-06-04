import 'package:dobareh_bloc/data/data_provider/local/auth_shared_preferences.dart';
import 'package:dobareh_bloc/data/data_provider/remote/auth/auth_api_provider.dart';
import 'package:dobareh_bloc/data/model/auth/login/verify_response.dart';
import 'package:dobareh_bloc/utils/network_response_to_result.dart';

import '../model/auth/login/login_response.dart';

class AuthRepository {
  final AuthApiProvider _apiProvider;
  final AuthSharedPreferences _appSharedPreferences;

  // String userToken = "";

  AuthRepository(this._apiProvider, this._appSharedPreferences);

  Future<LoginResponse> login(String number) async {
    return await NetworkResponseToResult<LoginResponse>().generalNetworkResult(
        LoginResponse.fromJson, _apiProvider.login(number));
  }

  Future<VerifyResponse> verify(String number, String code) async {
    return await NetworkResponseToResult<VerifyResponse>().generalNetworkResult(
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
