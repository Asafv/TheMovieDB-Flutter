import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:tmdbflutter/ui/details/details_page.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
}

class TextChanged extends SearchEvent {
  final String text;
  final DetailsType type;

  const TextChanged({@required this.text, @required this.type});

  @override
  List<Object> get props => [text];

  @override
  String toString() => 'TextChanged { text: $text }';
}
