import 'package:fimber/fimber.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tmdbflutter/bloc.dart';
import 'package:tmdbflutter/data/tmdb_repository.dart';
import 'package:tmdbflutter/models/item_type.dart';

enum ShowMoreState {
  onTheAirTvs,
  topRatedTvs,
  popularTvs,
  nowPlayingMovies,
  topRatedMovies,
  popularMovies,
  upcomingMovies
}

class ShowMoreBloc extends Bloc {
  final TmdbRepository _repo = TmdbRepository();

  ShowMoreState state;

  final _itemsSubject = BehaviorSubject<List<ItemType>>();
  Stream<List<ItemType>> get itemsStream => _itemsSubject.stream;

  int page = 1;
  int totalPages = 0;
  List<ItemType> items = List();

  ShowMoreBloc(this.state) {
    fetchMore();
  }

  @override
  void dispose() {
    _itemsSubject.close();
  }

  void fetchMore({bool isBottomReached = false}) async {
    switch (state) {
      case ShowMoreState.onTheAirTvs:
        var tv =
            await _repo.getTvOnTheAir(page: isBottomReached ? page + 1 : page);
        Fimber.d("OnTheAir: ${tv.results}");
        if (tv.error == null) {
          _updatePageAndItems(tv.page, tv.results);
        }
        break;
      case ShowMoreState.topRatedTvs:
        var tv =
            await _repo.getTvTopRated(page: isBottomReached ? page + 1 : page);
        Fimber.d("topRated: ${tv.results}");
        if (tv.error == null) {
          _updatePageAndItems(tv.page, tv.results);
        }
        break;
      case ShowMoreState.popularTvs:
        var tv =
            await _repo.getTvPopular(page: isBottomReached ? page + 1 : page);
        Fimber.d("popular: ${tv.results}");
        if (tv.error == null) {
          _updatePageAndItems(tv.page, tv.results);
        }
        break;
      case ShowMoreState.nowPlayingMovies:
        var m = await _repo.getMoviesNowPlaying(
            page: isBottomReached ? page + 1 : page);
        Fimber.d("nowPlaying: ${m.results.length}");
        if (m.error == null) {
          _updatePageAndItems(m.page, m.results);
        }
        break;
      case ShowMoreState.topRatedMovies:
        var m = await _repo.getMoviesTopRated(
            page: isBottomReached ? page + 1 : page);
        Fimber.d("topRated: ${m.results.length}");
        if (m.error == null) {
          _updatePageAndItems(m.page, m.results);
        }
        break;
      case ShowMoreState.popularMovies:
        var m = await _repo.getMoviesPopular(
            page: isBottomReached ? page + 1 : page);
        Fimber.d("popular: ${m.results.length}");
        if (m.error == null) {
          _updatePageAndItems(m.page, m.results);
        }
        break;
      case ShowMoreState.upcomingMovies:
        var m = await _repo.getMoviesUpcoming(
            page: isBottomReached ? page + 1 : page);
        Fimber.d("upcoming: ${m.results.length}");

        if (m.error == null) {
          _updatePageAndItems(m.page, m.results);
        }
        break;
    }

    _itemsSubject.sink.add(items);
  }

  void _updatePageAndItems(int page, List<ItemType> results) {
    this.page = page;
    items = items + results;
  }

  String getTitle() {
    switch (state) {
      case ShowMoreState.onTheAirTvs:
        return "On The Air Tv Shows";
      case ShowMoreState.topRatedTvs:
        return "Top Rated Tv Shows";
      case ShowMoreState.popularTvs:
        return "Popular Tv Shows";
      case ShowMoreState.nowPlayingMovies:
        return "Now Playing Movies";
      case ShowMoreState.topRatedMovies:
        return "Top Rated Movies";
      case ShowMoreState.popularMovies:
        return "Popular Movies";
      case ShowMoreState.upcomingMovies:
        return "Upcoming Movies";
    }
    return "";
  }
}
