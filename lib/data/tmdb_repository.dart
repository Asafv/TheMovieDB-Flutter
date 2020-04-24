import 'package:tmdbflutter/bloc/genres_bloc.dart';
import 'package:tmdbflutter/data/api/responses/genres_response.dart';
import 'package:tmdbflutter/data/api/responses/movies_response.dart';
import 'package:tmdbflutter/data/api/responses/tv_responses.dart';
import 'package:tmdbflutter/data/api/tmdb_api.dart';

class TmdbRepository {
  TmdbApi _api = TmdbApi();

  Future<MoviesResponse> getMoviesNowPlaying() {
    return _api.getMoviesNowPlaying();
  }

  Future<MoviesResponse> getMoviesTopRated() {
    return _api.getMoviesTopRated();
  }

  Future<MoviesResponse> getMoviesPopular() {
    return _api.getMoviesPopular();
  }

  Future<MoviesResponse> getMoviesUpcoming() {
    return _api.getMoviesUpcoming();
  }

  Future<TvResponses> getTvOnTheAir() {
    return _api.getTvOnTheAir();
  }

  Future<TvResponses> getTvTopRated() {
    return _api.getTvTopRated();
  }

  Future<TvResponses> getTvPopular() {
    return _api.getTvPopular();
  }

  Future<GenresResponse> getGenresByType(GenreType type) {
    if (type == GenreType.movie) {
      return _api.getMoviesGenres();
    }
    return _api.getTvGenres();
  }

  Future<MoviesResponse> searchMovies(String searchTerm) {
    return _api.searchMovies(searchTerm);
  }

  Future<TvResponses> searchTvShows(String searchTerm) {
    return _api.searchTvs(searchTerm);
  }

  getMovieById(int id) {
    return _api.getMovieById(id);
  }

  getTvById(int id) {
    return _api.getTvById(id);
  }
}
