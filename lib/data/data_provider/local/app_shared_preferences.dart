import 'package:shared_preferences/shared_preferences.dart';

const tokenKey = "LOGIN_TOKEN_KEY";

class AppSharedPreferences {
  late SharedPreferences prefs;

  Future<bool> saveToken(String token) async {
    prefs = await SharedPreferences.getInstance();
    return await prefs.setString(tokenKey, token);
  }

  Future<String> getToken()async {
    prefs = await SharedPreferences.getInstance();
    var token = prefs.getString(tokenKey);
    return token ?? "";
  }
}
