import 'package:dobareh_bloc/data/data_provider/local/app_shared_preferences.dart';

class UserRepository {
  final AppSharedPreferences _appSharedPreferences;

  UserRepository(this._appSharedPreferences);

  Future<bool> saveToken(String token) async {
    return await _appSharedPreferences.saveToken(token);
  }

  Future<String> getToken() async {
    return await _appSharedPreferences.getToken();
  }
}
