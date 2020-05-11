import 'package:fimber/fimber.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdbflutter/bloc/search/search_event.dart';
import 'package:tmdbflutter/bloc/search/search_state.dart';
import 'package:tmdbflutter/data/api/responses/movies_response.dart';
import 'package:tmdbflutter/data/api/responses/tv_responses.dart';
import 'package:tmdbflutter/data/tmdb_repository.dart';
import 'package:tmdbflutter/models/item_type.dart';
import 'package:tmdbflutter/ui/details/details_page.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final TmdbRepository tmdbRepository = TmdbRepository();

  List<ItemType> items;

  int page;
  int totalPages;
  String lastSearchTerm;
  DetailsType lastEventType;

  @override
  SearchState get initialState => SearchStateEmpty();

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is TextChanged) {
      lastSearchTerm = event.text;
      if (lastSearchTerm.isEmpty) {
        yield SearchStateEmpty();
      } else {
        yield SearchStateLoading();
        try {
          lastEventType = event.type;

          if (event.type == DetailsType.movie) {
            MoviesResponse results =
                await tmdbRepository.searchMovies(lastSearchTerm);
            page = results.page;
            totalPages = results.totalPages;
            items = results.results;
            yield SearchStateSuccess(type: event.type, movies: items);
          } else {
            TvResponses results =
                await tmdbRepository.searchTvShows(lastSearchTerm);
            page = results.page;
            totalPages = results.totalPages;
            items = results.results;

            yield SearchStateSuccess(type: event.type, tvs: items);
          }
        } catch (error) {
          yield SearchStateError(error);
        }
      }
    }

    if (event is BottomScrollReached) {
      Fimber.d("BottomScrollReached, page: $page");
      if (page < totalPages) {
        try {
          if (lastEventType == DetailsType.movie) {
            MoviesResponse results = await tmdbRepository
                .searchMovies(lastSearchTerm, page: page + 1);
            page = results.page;
            items = items + results.results;
            yield SearchStateSuccess(type: lastEventType, movies: items);
          } else {
            TvResponses results = await tmdbRepository
                .searchTvShows(lastSearchTerm, page: page + 1);
            page = results.page;
            items = items + results.results;
            yield SearchStateSuccess(type: lastEventType, tvs: items);
          }
        } catch (error) {
          Fimber.e("error: $error");
          yield SearchStateError(error);
        }
      }
    }
  }
}
