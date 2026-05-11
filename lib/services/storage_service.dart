import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static late SharedPreferences prefs;

  static Future init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static Future saveLogin(String user) async {
    await prefs.setBool("is_logged_in", true);
    await prefs.setString("username", user);
  }

  static bool isLoggedIn() {
    return prefs.getBool("is_logged_in") ?? false;
  }

  static Future logout() async {
    await prefs.clear();
  }
}