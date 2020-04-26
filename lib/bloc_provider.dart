import 'package:flutter/material.dart';
import 'package:tmdbflutter/bloc.dart';

// 1 declare the BlocProvider to receive Bloc type class
class BlocProvider<T extends Bloc> extends StatefulWidget {
  final Widget child;
  final T bloc;

  const BlocProvider({Key key, @required this.bloc, @required this.child})
      : super(key: key);

  // 2 get the bloc from the context ancestor widget
  static T of<T extends Bloc>(BuildContext context) {
    final BlocProvider<T> provider = context.findAncestorWidgetOfExactType();
    return provider.bloc;
  }

  @override
  State createState() => _BlocProviderState();
}

class _BlocProviderState extends State<BlocProvider> {
  // 3 return the BlocProvider child widget
  @override
  Widget build(BuildContext context) => widget.child;

  // 4 disposes the bloc
  @override
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
  }
}
