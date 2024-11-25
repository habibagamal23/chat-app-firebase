import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  static late SharedPreferences _preferences;

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static bool getTheme() {
    return _preferences.getBool("isDark") ?? false;
  }

  static Future<void> setTheme(bool isDark) async {
    await _preferences.setBool("isDark", isDark);
  }
}