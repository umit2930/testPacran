import 'package:dobareh_bloc/data/data_provider/remote/auth_api_provider.dart';
import 'package:dobareh_bloc/utils/network_response_to_result.dart';

import '../model/auth/login/LoginResponse.dart';

class AuthRepository {
  final ApiProvider _apiProvider = ApiProvider();

  Future<LoginResponse> login(String number) async {
    return await NetworkResponseToResult<LoginResponse>().generalNetworkResult(
        LoginResponse.fromJson, _apiProvider.login(number));
  }
}
