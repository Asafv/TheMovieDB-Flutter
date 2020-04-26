import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdbflutter/bloc/search/search_bloc.dart';
import 'package:tmdbflutter/bloc/search/search_state.dart';
import 'package:tmdbflutter/ui/details/details_page.dart';
import 'package:tmdbflutter/ui/search/search_result_widget.dart';

class SearchBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state is SearchStateLoading) {
          return _centeredWidget(CircularProgressIndicator());
        }
        if (state is SearchStateError) {
          return _centeredWidget(Text(state.error));
        }
        if (state is SearchStateSuccess) {
          switch (state.type) {
            case DetailsType.movie:
              return state.movies.isEmpty
                  ? _centeredWidget(Text('No Results'))
                  : Expanded(
                      child: SearchResults(
                        items: state.movies,
                      ),
                    );
            case DetailsType.tv:
              return state.tvs.isEmpty
                  ? _centeredWidget(Text('No Results'))
                  : Expanded(
                      child: SearchResults(
                        items: state.tvs,
                      ),
                    );
          }
        }
        return _centeredWidget(Text('Please enter a term to begin'));
      },
    );
  }

  Container _centeredWidget(Widget child) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Center(child: child),
    );
  }
}
