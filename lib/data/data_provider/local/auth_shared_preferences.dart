import 'package:shared_preferences/shared_preferences.dart';

const tokenKey = "LOGIN_TOKEN_KEY";

class AuthSharedPreferences {
  static late SharedPreferences _prefs;

  static Future<AuthSharedPreferences> getInstance() async{
    var shared = await SharedPreferences.getInstance();
  return AuthSharedPreferences._private(shared);
  }

  AuthSharedPreferences._private(SharedPreferences sharedPreferences){
    _prefs = sharedPreferences;
  }


  Future<bool> saveToken(String token) async {
    //TODO what happen if we remove the await?
    return await _prefs.setString(tokenKey, token);
  }

  Future<bool> removeToken() async {
    var isRemoved = await _prefs.remove(tokenKey);
    return isRemoved;
  }

  Future<String?> getToken() async {
    var token = _prefs.getString(tokenKey);
    return token ;
  }


}
