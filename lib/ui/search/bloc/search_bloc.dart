import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdbflutter/api/responses/movies_response.dart';
import 'package:tmdbflutter/api/responses/tv_responses.dart';
import 'package:tmdbflutter/repo/tmdb_repository.dart';
import 'package:tmdbflutter/ui/details/details_page.dart';
import 'package:tmdbflutter/ui/search/bloc/search_event.dart';
import 'package:tmdbflutter/ui/search/bloc/search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final TmdbRepository tmdbRepository = TmdbRepository();

  @override
  SearchState get initialState => SearchStateEmpty();

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is TextChanged) {
      final String searchTerm = event.text;
      if (searchTerm.isEmpty) {
        yield SearchStateEmpty();
      } else {
        yield SearchStateLoading();
        try {
          if (event.type == DetailsType.movie) {
            MoviesResponse results =
                await tmdbRepository.searchMovies(searchTerm);
            yield SearchStateSuccess(type: event.type, movies: results.results);
          } else {
            TvResponses results =
                await tmdbRepository.searchTvShows(searchTerm);
            yield SearchStateSuccess(type: event.type, tvs: results.results);
          }
        } catch (error) {
          yield SearchStateError(error);
        }
      }
    }
  }
}
