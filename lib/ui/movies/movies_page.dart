import 'package:fimber/fimber.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tmdbflutter/models/item_type.dart';
import 'package:tmdbflutter/models/movie.dart';
import 'package:tmdbflutter/ui/details/details_page.dart';
import 'package:tmdbflutter/ui/movies/movies_bloc.dart';
import 'package:tmdbflutter/ui/show_more/show_more_bloc.dart';
import 'package:tmdbflutter/ui/widgets/items_list.dart';
import 'package:tmdbflutter/utils/app_navigator.dart';

class MoviesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MoviesPage();
}

class _MoviesPage extends State<MoviesPage> {
  final MoviesBloc _moviesBloc = MoviesBloc();

  List<Widget> _moviesList;

  double itemWidth;

  _onClick(Movie m) {
    Fimber.d("onClick: ${m.title}");
    AppNavigator.goToDetails(context, DetailsType.movie, movie: m);
  }

  @override
  void dispose() {
    super.dispose();
    _moviesBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    itemWidth = MediaQuery.of(context).size.width;
    _moviesList = _initMoviesList();

    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: _moviesList,
      ),
    );
  }

  List<Widget> _initMoviesList() {
    var list = List<Widget>();
    list.add(Container(
      height: 20,
    ));
    list.add(ItemsList(
//      itemWidth: itemWidth * .75,
      listTitle: "Now Playing",
      itemsStream: _moviesBloc.nowPlayingMovies,
      onItemClicked: (ItemType item) => _onClick((item as Movie)),
      onMoreClicked: (List<ItemType> items) =>
          showMorePage(items, ShowMoreTypes.nowPlayingMovies),
    ));
    list.add(Container(
      height: 20,
    ));
    list.add(ItemsList(
      listTitle: "Popular",
      itemsStream: _moviesBloc.popularMovies,
      onItemClicked: (ItemType item) => _onClick((item as Movie)),
      onMoreClicked: (List<ItemType> items) =>
          showMorePage(items, ShowMoreTypes.popularMovies),
    ));
    list.add(Container(
      height: 20,
    ));
    list.add(ItemsList(
      listTitle: "Upcoming",
      itemsStream: _moviesBloc.upcomingMovies,
      onItemClicked: (ItemType item) => _onClick((item as Movie)),
      onMoreClicked: (List<ItemType> items) =>
          showMorePage(items, ShowMoreTypes.upcomingMovies),
    ));
    list.add(Container(
      height: 20,
    ));
    list.add(ItemsList(
      listTitle: "Top Rated",
      itemsStream: _moviesBloc.topRatedMovies,
      onItemClicked: (ItemType item) => _onClick((item as Movie)),
      onMoreClicked: (List<ItemType> items) =>
          showMorePage(items, ShowMoreTypes.topRatedMovies),
    ));
    return list;
  }

  void showMorePage(List<ItemType> items, state) {
    return AppNavigator.showMorePage(context, state, items);
  }
}
