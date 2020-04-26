import 'dart:io';

import 'package:fimber/fimber.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tmdbflutter/bloc/theme_bloc.dart';
import 'package:tmdbflutter/bloc_provider.dart';
import 'package:tmdbflutter/ui/home/home_page.dart';
import 'package:tmdbflutter/ui/movies/movies_page.dart';
import 'package:tmdbflutter/ui/tv/tv_page.dart';
import 'package:tmdbflutter/utils/theme_utils.dart';

void main() {
  Fimber.plantTree(DebugTree.elapsed());

  FlutterError.onError = (FlutterErrorDetails details) {
    print(details.exceptionAsString());
    FlutterError.dumpErrorToConsole(details);
    if (kReleaseMode) exit(1);
  };

  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  MainApp({Key key}) : super(key: key);

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  ThemeBloc _themeBloc;

  @override
  void initState() {
    _themeBloc = ThemeBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //    SystemChrome.setPreferredOrientations([
//      DeviceOrientation.portraitUp,
//      DeviceOrientation.portraitDown,
//    ]);

    return BlocProvider<ThemeBloc>(
      bloc: _themeBloc,
      child: StreamBuilder<ThemeState>(
        stream: _themeBloc.themeStateStream,
        initialData: _themeBloc.lastTheme,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          var isDark = snapshot.data == ThemeState.dark;
          Fimber.d("themeTypeStream, isDark : $isDark");
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme:
                isDark ? ThemeUtils.getDarkTheme() : ThemeUtils.getLightTheme(),
            home: HomePage(),
            routes: {
              "/movie_page": (BuildContext context) => MoviesPage(),
              "/tv_page": (BuildContext context) => TvPage(),
            },
          );
        },
      ),
    );
  }
}
