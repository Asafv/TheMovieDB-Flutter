import 'package:fimber/fimber.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tmdbflutter/bloc.dart';
import 'package:tmdbflutter/utils/prefs.dart';

enum ThemeType { dark, light }

class ThemeBloc implements Bloc {
  final _themeSubject = BehaviorSubject<ThemeType>();
  final Prefs _prefs = Prefs();

  bool _lastTheme = false;
  ThemeType get lastTheme => _lastTheme ? ThemeType.dark : ThemeType.light;

  Stream<ThemeType> get themeTypeStream => _themeSubject.stream;

  ThemeBloc() {
    _loadPreviousTheme();
  }

  @override
  void dispose() {
    _themeSubject.close();
  }

  void changeTheme(bool isDark) async {
    Fimber.d("changeTheme: $isDark");
    await _prefs.saveBool(Prefs.K_LAST_THEME_TYPE, isDark);
    var type = isDark ? ThemeType.dark : ThemeType.light;
    _themeSubject.sink.add(type);
  }

  void _loadPreviousTheme() async {
    _lastTheme = await _prefs.getBool(Prefs.K_LAST_THEME_TYPE) ?? false;
    changeTheme(_lastTheme);
  }
}
