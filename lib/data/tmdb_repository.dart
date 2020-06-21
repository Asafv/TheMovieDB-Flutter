import 'package:tmdbflutter/bloc/genres_bloc.dart';
import 'package:tmdbflutter/data/api/responses/genres_response.dart';
import 'package:tmdbflutter/data/api/responses/movies_response.dart';
import 'package:tmdbflutter/data/api/responses/tv_responses.dart';
import 'package:tmdbflutter/data/api/tmdb_api.dart';

class TmdbRepository {
  TmdbApi _api = TmdbApi();

  Future<MoviesResponse> getMoviesNowPlaying({int page = 1}) {
    return _api.getMoviesNowPlaying(page);
  }

  Future<MoviesResponse> getMoviesTopRated({int page = 1}) {
    return _api.getMoviesTopRated(page);
  }

  Future<MoviesResponse> getMoviesPopular({int page = 1}) {
    return _api.getMoviesPopular(page);
  }

  Future<MoviesResponse> getMoviesUpcoming({int page = 1}) {
    return _api.getMoviesUpcoming(page);
  }

  Future<TvResponses> getTvOnTheAir({int page = 1}) {
    return _api.getTvOnTheAir(page);
  }

  Future<TvResponses> getTvTopRated({int page = 1}) {
    return _api.getTvTopRated(page);
  }

  Future<TvResponses> getTvPopular({int page = 1}) {
    return _api.getTvPopular(page);
  }

  Future<GenresResponse> getGenresByType(GenreType type) {
    if (type == GenreType.movie) {
      return _api.getMoviesGenres();
    }
    return _api.getTvGenres();
  }

  Future<MoviesResponse> searchMovies(String searchTerm, {int page = 1}) {
    return _api.searchMovies(searchTerm, page);
  }

  Future<TvResponses> searchTvShows(String searchTerm, {int page = 1}) {
    return _api.searchTvs(searchTerm, page);
  }

  getMovieById(int id) {
    return _api.getMovieById(id);
  }

  getTvById(int id) {
    return _api.getTvById(id);
  }
}
