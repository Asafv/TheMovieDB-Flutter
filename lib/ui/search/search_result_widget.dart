import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdbflutter/bloc/search/search_bloc.dart';
import 'package:tmdbflutter/bloc/search/search_event.dart';
import 'package:tmdbflutter/models/item_type.dart';
import 'package:tmdbflutter/models/movie.dart';
import 'package:tmdbflutter/ui/details/details_page.dart';
import 'package:tmdbflutter/ui/widgets/list_item.dart';
import 'package:tmdbflutter/utils/app_navigator.dart';

class SearchResults extends StatefulWidget {
  final List<ItemType> items;

  const SearchResults({Key key, this.items}) : super(key: key);

  @override
  _SearchResultsState createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  ScrollController _controller = ScrollController();

  SearchBloc _searchBloc;

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      Fimber.d("reach the bottom");
      _searchBloc.add(BottomScrollReached());
    }
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      Fimber.d("reach the top");
    }
  }

  @override
  void initState() {
    super.initState();
    _searchBloc = BlocProvider.of<SearchBloc>(context);
    _controller.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Fimber.d("widget.items.length - ${widget.items.length}");
    return GridView.count(
      controller: _controller,
      crossAxisCount: 2,
      childAspectRatio: .8,
      shrinkWrap: true,
      children: List.generate(widget.items.length, (index) {
        return ListItem(
          itemWidth: 140,
          item: widget.items[index],
          onClick: (item) {
            if (widget.items[index] is Movie) {
              AppNavigator.goToDetails(context, DetailsType.movie,
                  movie: widget.items[index]);
            } else {
              AppNavigator.goToDetails(context, DetailsType.tv,
                  tv: widget.items[index]);
            }
          },
        );
      }, growable: true),
    );
  }
}
