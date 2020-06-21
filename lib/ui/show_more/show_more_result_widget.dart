import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:tmdbflutter/bloc_provider.dart';
import 'package:tmdbflutter/models/item_type.dart';
import 'package:tmdbflutter/models/movie.dart';
import 'package:tmdbflutter/ui/details/details_page.dart';
import 'package:tmdbflutter/ui/show_more/show_more_bloc.dart';
import 'package:tmdbflutter/ui/widgets/list_item.dart';
import 'package:tmdbflutter/utils/app_navigator.dart';

class ShowMoreResults extends StatefulWidget {
  final List<ItemType> items;

  const ShowMoreResults({Key key, this.items}) : super(key: key);

  @override
  _ShowMoreResultsState createState() => _ShowMoreResultsState();
}

class _ShowMoreResultsState extends State<ShowMoreResults> {
  ScrollController _controller = ScrollController();

  ShowMoreBloc _showMoreBloc;

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      Fimber.d("reach the bottom");
      _showMoreBloc.fetchMore(isBottomReached: true);
    }
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      Fimber.d("reach the top");
    }
  }

  @override
  void initState() {
    super.initState();
    _showMoreBloc = BlocProvider.of<ShowMoreBloc>(context);
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
      childAspectRatio: .65,
      shrinkWrap: true,
      children: List.generate(widget.items.length, (index) {
        return ListItem(
          itemWidth: 200,
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
