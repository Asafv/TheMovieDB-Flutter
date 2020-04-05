import 'package:fimber/fimber.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tmdbflutter/models/movie.dart';
import 'package:tmdbflutter/repo/tmdb_repository.dart';

class MoviesBloc {
  final TmdbRepository _repo = TmdbRepository();

  final _nowPlayingSubject = BehaviorSubject<List<Movie>>();
  final _topRatedSubject = BehaviorSubject<List<Movie>>();
  final _popularSubject = BehaviorSubject<List<Movie>>();
  final _upcomingSubject = BehaviorSubject<List<Movie>>();

  Stream<List<Movie>> get nowPlayingMovies => _nowPlayingSubject.stream;
  Stream<List<Movie>> get topRatedMovies => _topRatedSubject.stream;
  Stream<List<Movie>> get popularMovies => _popularSubject.stream;
  Stream<List<Movie>> get upcomingMovies => _upcomingSubject.stream;

  MoviesBloc() {
    _fetchMovies();
  }

  dispose() {
    _nowPlayingSubject.close();
    _topRatedSubject.close();
    _popularSubject.close();
    _upcomingSubject.close();
  }

  void _fetchMovies() async {
    var m = await _repo.getMoviesNowPlaying();
    Fimber.d("nowPlaying: ${m.results.length}");
    if (m.error == null) {
      _nowPlayingSubject.sink.add(m.results);
    }

    m = await _repo.getMoviesTopRated();
    Fimber.d("topRated: ${m.results.length}");
    if (m.error == null) {
      _topRatedSubject.sink.add(m.results);
    }

    m = await _repo.getMoviesPopular();
    Fimber.d("popular: ${m.results.length}");
    if (m.error == null) {
      _popularSubject.sink.add(m.results);
    }

    m = await _repo.getMoviesUpcoming();
    Fimber.d("upcoming: ${m.results.length}");

    if (m.error == null) {
      _upcomingSubject.sink.add(m.results);
    }
  }
}
