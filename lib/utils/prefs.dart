import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static final Prefs _singleton = new Prefs._internal();
  static const String K_LAST_SELECTED_PAGE = "k_last_selected_page";

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

  saveString(String uri, String data) async {
    final SharedPreferences prefs = await _prefs;

    await prefs.setString(uri, data).then((bool success) {
      print("$this,$uri: save success: $success");
    });
  }

  saveInt(String uri, String data) async {
    final SharedPreferences prefs = await _prefs;

    await prefs.setString(uri, data).then((bool success) {
      print("$this,$uri: save success: $success");
    });
  }

  Future<String> getString(String key) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString(key);
  }
}
