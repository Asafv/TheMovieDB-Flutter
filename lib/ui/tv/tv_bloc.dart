import 'package:fimber/fimber.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tmdbflutter/data/tmdb_repository.dart';
import 'package:tmdbflutter/models/tv.dart';

class TvBloc {
  final TmdbRepository _repo = TmdbRepository();

  final _onTheAirSubject = BehaviorSubject<List<Tv>>();
  final _topRatedSubject = BehaviorSubject<List<Tv>>();
  final _popularSubject = BehaviorSubject<List<Tv>>();

  Stream<List<Tv>> get onTheAirTvs => _onTheAirSubject.stream;
  Stream<List<Tv>> get topRatedTvs => _topRatedSubject.stream;
  Stream<List<Tv>> get popularTvs => _popularSubject.stream;

  TvBloc() {
    _fetchTvShows();
  }

  dispose() {
    _onTheAirSubject.close();
    _topRatedSubject.close();
    _popularSubject.close();
  }

  void _fetchTvShows() async {
    var tv = await _repo.getTvOnTheAir();
    Fimber.d("OnTheAir: ${tv.results}");
    if (tv.error == null) {
      _onTheAirSubject.sink.add(tv.results);
    }

    tv = await _repo.getTvTopRated();
    Fimber.d("topRated: ${tv.results}");
    if (tv.error == null) {
      _topRatedSubject.sink.add(tv.results);
    }

    tv = await _repo.getTvPopular();
    Fimber.d("popular: ${tv.results}");
    if (tv.error == null) {
      _popularSubject.sink.add(tv.results);
    }
  }
}
