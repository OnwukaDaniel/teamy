import 'package:teamy/imports.dart';

class LocalStorage {
  static final LocalStorage _instance = LocalStorage._internal();
  static SharedPreferences? _pref;

  factory LocalStorage() => _instance;

  LocalStorage._internal();

  static Future<void> init() async {
    _pref ??= await SharedPreferences.getInstance();
  }

  static setString(String key, String value) async {
    await init();
    _pref?.setString(key, value);
  }

  static Future<String> getString(String key) async {
    await init();
    return _pref?.getString(key) ?? "";
  }

  static setBool(String key, bool value) async {
    await init();
    _pref?.setBool(key, value);
  }

  static Future<bool> getBool(String key) async {
    await init();
    return _pref?.getBool(key) ?? false;
  }

  static setStringList(String key, List<String> value) async {
    await init();
    _pref?.setStringList(key, value);
  }

  static Future<List<String>> getStringList(String key) async {
    await init();
    return _pref?.getStringList(key) ?? [];
  }

  static clear() async {
    await init();
    _pref?.clear();
  }
}
