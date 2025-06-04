import 'package:teamy/imports.dart';

class LocalStorage {
  static final LocalStorage _instance = LocalStorage._internal();
  static SharedPreferences? _pref;

  factory LocalStorage() => _instance;

  LocalStorage._internal();

  static Future<void> init() async {
    _pref ??= await SharedPreferences.getInstance();
  }

  static setString(String key, String value) {
    _pref?.setString(key, value);
  }

  static String getString(String key) {
    return _pref?.getString(key) ?? "";
  }

  static setBool(String key, bool value) {
    _pref?.setBool(key, value);
  }

  static bool getBool(String key) {
    return _pref?.getBool(key) ?? false;
  }

  static setStringList(String key, List<String> value) {
    _pref?.setStringList(key, value);
  }

  static List<String> getStringList(String key) {
    return _pref?.getStringList(key) ?? [];
  }

  static clear() {
    _pref?.clear();
  }
}
