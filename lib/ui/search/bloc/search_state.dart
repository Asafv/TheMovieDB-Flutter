import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:tmdbflutter/models/movie.dart';
import 'package:tmdbflutter/models/tv.dart';
import 'package:tmdbflutter/ui/details/details_page.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchStateEmpty extends SearchState {}

class SearchStateLoading extends SearchState {}

class SearchStateSuccess extends SearchState {
  final List<Movie> movies;
  final List<Tv> tvs;
  final DetailsType type;

  const SearchStateSuccess({@required this.type, this.movies, this.tvs});

  @override
  List<Object> get props => [movies, tvs];

  @override
  String toString() =>
      'SearchStateSuccess { movies: ${movies.length} , tvs: ${tvs.length} }';
}

class SearchStateError extends SearchState {
  final String error;

  const SearchStateError(this.error);

  @override
  List<Object> get props => [error];
}
