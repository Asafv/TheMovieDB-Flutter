import 'package:flutter/material.dart';
import 'package:tmdbflutter/bloc/theme_bloc.dart';

class ThemeUtils {
  static var splashColor = Colors.lightGreen;

  static getBackgroundColor(ThemeType type) {
    if (type == ThemeType.dark) {
      return Colors.black;
    }
    return Colors.white;
  }

  static getLightTheme() {
    var theme = ThemeData(primaryColor: Colors.white);
    return theme;
  }

  static getDarkTheme() {
    var theme = ThemeData(brightness: Brightness.dark);
    return theme;
  }
}
