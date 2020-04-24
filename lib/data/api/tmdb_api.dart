import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:tmdbflutter/data/api/responses/genres_response.dart';
import 'package:tmdbflutter/data/api/responses/movies_response.dart';
import 'package:tmdbflutter/data/api/responses/tv_responses.dart';
import 'package:tmdbflutter/data/api/responses/video_response.dart';
import 'package:tmdbflutter/models/movie.dart';
import 'package:tmdbflutter/models/tv.dart';

enum ImageSizes { small, normal, large }

class TmdbApi {
  static final String _token =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5OWU0OWUzODg3ZWE0ZWU1NDY1ZTFjNjhhOGNhNmJmMCIsInN1YiI6IjU4NjIyYzgzYzNhMzY4MWE3ZDAzOWQ2YiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.nL8_22Gn19SOJJocosQea2Y2UobbKF9jb5HRHwAiN-0";

  /// EndPoints
  static final String _baseUrl = "https://api.themoviedb.org/3";
  static final String _movieEndpoint = "$_baseUrl/movie";
  static final String _tvEndpoint = "$_baseUrl/tv";

  /// Genres
  static final String _movieGenresEndpoint = "$_baseUrl/genre/movie/list";
  static final String _tvGenresEndpoint = "$_baseUrl/genre/tv/list";

  /// Search
  static final String _tvSearchEndpoint = "$_baseUrl/search/tv?query=";
  static final String _moviesSearchEndpoint = "$_baseUrl/search/movie?query=";

  /// Images
  static final String _imageUrl = "https://image.tmdb.org/t/p";

  Dio _dio;

  TmdbApi() {
    /// Create Dio Object using baseOptions set receiveTimeout,connectTimeout
    BaseOptions options =
        BaseOptions(receiveTimeout: 5000, connectTimeout: 5000);
    options.baseUrl = _baseUrl;
    options.headers = {"authorization": "Bearer $_token"};
    _dio = Dio(options);

    /// Interceptors
    _dio.interceptors.add(LogInterceptor());

    // Fixme Cache not working!
    _dio.interceptors.add(DioCacheManager(CacheConfig(
      baseUrl: _baseUrl,
      defaultMaxAge: Duration(days: 14),
    )).interceptor);
  }

  Future<MoviesResponse> getMoviesNowPlaying() async {
    try {
      Response response = await _dio.get("$_movieEndpoint/now_playing");
      return MoviesResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return MoviesResponse.withError("$error");
    }
  }

  Future<MoviesResponse> getMoviesTopRated() async {
    try {
      Response response = await _dio.get("$_movieEndpoint/top_rated");
      return MoviesResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return MoviesResponse.withError("$error");
    }
  }

  Future<MoviesResponse> getMoviesPopular() async {
    try {
      Response response = await _dio.get("$_movieEndpoint/popular");
      return MoviesResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return MoviesResponse.withError("$error");
    }
  }

  Future<MoviesResponse> getMoviesUpcoming() async {
    try {
      Response response = await _dio.get("$_movieEndpoint/upcoming");
      return MoviesResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return MoviesResponse.withError("$error");
    }
  }

  Future<Movie> getMovieById(int id) async {
    try {
      Response response = await _dio.get("$_movieEndpoint/$id");
      return Movie.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return Movie.withError("$error");
    }
  }

  Future<VideoResponse> getMovieVideos(int id) async {
    try {
      Response response = await _dio.get("$_movieEndpoint/$id/videos");
      return VideoResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return VideoResponse.withError("$error");
    }
  }

  Future<GenresResponse> getMoviesGenres() async {
    try {
      Response response = await _dio.get("$_movieGenresEndpoint");
      return GenresResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return GenresResponse.withError("$error");
    }
  }

  Future<MoviesResponse> searchMovies(String searchTerm) async {
    final query = searchTerm.replaceAll(" ", "+");
    try {
      Response response = await _dio.get("$_moviesSearchEndpoint$query");
      return MoviesResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return MoviesResponse.withError("$error");
    }
  }

  Future<GenresResponse> getTvGenres() async {
    try {
      Response response = await _dio.get("$_tvGenresEndpoint");
      return GenresResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return GenresResponse.withError("$error");
    }
  }

  Future<TvResponses> getTvOnTheAir() async {
    try {
      Response response = await _dio.get("$_tvEndpoint/on_the_air");
      return TvResponses.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return TvResponses.withError("$error");
    }
  }

  Future<TvResponses> getTvPopular() async {
    try {
      Response response = await _dio.get("$_tvEndpoint/popular");
      return TvResponses.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return TvResponses.withError("$error");
    }
  }

  Future<TvResponses> getTvTopRated() async {
    try {
      Response response = await _dio.get("$_tvEndpoint/top_rated");
      return TvResponses.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return TvResponses.withError("$error");
    }
  }

  Future<Tv> getTvById(int id) async {
    try {
      Response response = await _dio.get("$_tvEndpoint/$id");
      return Tv.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return Tv.withError("$error");
    }
  }

  Future<TvResponses> searchTvs(String searchTerm) async {
    final query = searchTerm.replaceAll(" ", "+");
    try {
      Response response = await _dio.get("$_tvSearchEndpoint$query");
      return TvResponses.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return TvResponses.withError("$error");
    }
  }

  String getImageUrl(String path, {ImageSizes size = ImageSizes.small}) {
    switch (size) {
      case ImageSizes.small:
        return "$_imageUrl/w154/$path";
        break;
      case ImageSizes.normal:
        return "$_imageUrl/w500/$path";
        break;
      case ImageSizes.large:
        return "$_imageUrl/original/$path";
        break;

      default:
        return "$_imageUrl/w500/$path";
    }
  }
}
