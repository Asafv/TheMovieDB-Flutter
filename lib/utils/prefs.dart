import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static final Prefs _singleton = new Prefs._internal();
  static const String K_LAST_SELECTED_PAGE = "k_last_selected_page";
  static const String K_LAST_THEME_TYPE = "k_last_theme_type";

  factory Prefs() {
    return _singleton;
  }

  Prefs._internal() {
    getPrefs();
  }

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<SharedPreferences> getPrefs() async {
    return await _prefs;
  }

  saveInt(String uri, String data) async {
    final SharedPreferences prefs = await _prefs;

    await prefs.setString(uri, data).then((bool success) {
      print("$this,$uri: save success: $success");
    });
  }

  saveString(String uri, String data) async {
    final SharedPreferences prefs = await _prefs;

    await prefs.setString(uri, data).then((bool success) {
      print("$this,$uri: save success: $success");
    });
  }

  Future<String> getString(String key) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString(key);
  }

  saveBool(String uri, bool data) async {
    final SharedPreferences prefs = await _prefs;

    await prefs.setBool(uri, data).then((bool success) {
      print("$this,$uri: save success: $success");
    });
  }

  Future<bool> getBool(String key) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getBool(key);
  }
}
