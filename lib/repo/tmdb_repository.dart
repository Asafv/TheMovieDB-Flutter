import 'package:tmdbflutter/api/responses/movies_response.dart';
import 'package:tmdbflutter/api/responses/tv_responses.dart';
import 'package:tmdbflutter/api/tmdb_api.dart';

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
}
