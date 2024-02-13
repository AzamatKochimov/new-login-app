import 'package:shared_preferences/shared_preferences.dart';

class TokenService {
  static const String _tokenKey = 'token';

  static Future<void> setToken(String token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(_tokenKey, token);
  }

  static Future<String?> getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(_tokenKey);
  }

  static Future<void> removeToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove(_tokenKey);
  }
}

