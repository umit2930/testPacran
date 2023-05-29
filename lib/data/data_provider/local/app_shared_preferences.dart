import 'package:shared_preferences/shared_preferences.dart';

const tokenKey = "TOKEN_KEY";

class AppSharedPreferences {
  late SharedPreferences prefs;

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<void> saveToken(String token) async {
    prefs.setString(tokenKey, token);
  }

  String getToken() {
    var token = prefs.getString(tokenKey);
    return token ?? "";
  }
}
