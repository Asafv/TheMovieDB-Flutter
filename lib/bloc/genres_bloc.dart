import 'package:fimber/fimber.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tmdbflutter/bloc.dart';
import 'package:tmdbflutter/data/api/responses/genres_response.dart';
import 'package:tmdbflutter/data/tmdb_repository.dart';
import 'package:tmdbflutter/models/genre.dart';

enum GenreType { movie, tv }

class GenresBloc implements Bloc {
  final TmdbRepository _repo = TmdbRepository();

  final _genresSubject = BehaviorSubject<List<Genre>>();

  Stream<List<Genre>> get genresStream => _genresSubject.stream;

  GenresBloc({@required GenreType genreType}) {
    changeGenres(genreType);
  }

  @override
  void dispose() {
    _genresSubject.close();
  }

  void changeGenres(GenreType type) async {
    Fimber.d("changeGenres: $type");
    GenresResponse res = await _repo.getGenresByType(type);
    Fimber.d("genres.length: ${res.genres.length}");
    _genresSubject.sink.add(res.genres);
  }
}
