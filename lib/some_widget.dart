import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:tmdbflutter/bloc/theme_bloc.dart';
import 'package:tmdbflutter/bloc_provider.dart';

class SomeWidget extends StatefulWidget {
  @override
  _SomeWidgetState createState() => _SomeWidgetState();
}

class _SomeWidgetState extends State<SomeWidget> {
  ThemeBloc _themeBloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _themeBloc = BlocProvider.of<ThemeBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ThemeState>(
        stream: _themeBloc.themeStateStream,
        builder: (context, snapshot) {
          var isDark = snapshot.data == ThemeState.dark;
          Fimber.d("ThemeState, isDark : $isDark");
          var color = isDark ? Colors.green : Colors.blue;
          return Container(
            color: color,
          );
        });
  }
}
