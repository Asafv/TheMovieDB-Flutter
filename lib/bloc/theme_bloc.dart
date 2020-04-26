import 'package:fimber/fimber.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tmdbflutter/bloc.dart';
import 'package:tmdbflutter/utils/prefs.dart';

enum ThemeState { dark, light }

class ThemeBloc implements Bloc {
  final _themeStateSubject = BehaviorSubject<ThemeState>();
  final Prefs _prefs = Prefs();

  bool _lastTheme = false;
  ThemeState get lastTheme => _lastTheme ? ThemeState.dark : ThemeState.light;

  Stream<ThemeState> get themeStateStream => _themeStateSubject.stream;

  ThemeBloc() {
    _loadPreviousTheme();
  }

  @override
  void dispose() {
    _themeStateSubject.close();
  }

  Future<void> changeTheme(bool isDark) async {
    Fimber.d("changeTheme: $isDark");
    await _prefs.saveBool(Prefs.K_LAST_THEME_TYPE, isDark);
    var type = isDark ? ThemeState.dark : ThemeState.light;
    _themeStateSubject.sink.add(type);
    return;
  }

  void _loadPreviousTheme() async {
    Fimber.d("_loadPreviousTheme");
    _lastTheme = await _prefs.getBool(Prefs.K_LAST_THEME_TYPE) ?? false;
    changeTheme(_lastTheme);
  }
}
