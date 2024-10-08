import 'package:shared_preferences/shared_preferences.dart';

class AppPrefKey {
  static const String kCheeringText = 'CheeringText';
}

class LocalDefaults {
  // reset all defaults
  static void initAllLocalDefaults() {

  }

  static Future saveText(String text) async {
    final pref = await SharedPreferences.getInstance();
    return await pref.setString(AppPrefKey.kCheeringText, text);
  }

  static Future<String> loadText() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString(AppPrefKey.kCheeringText) ?? '';
  }
}
