import 'package:fimber/fimber.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tmdbflutter/models/movie.dart';
import 'package:tmdbflutter/ui/details/details_page.dart';
import 'package:tmdbflutter/ui/movies/movies_bloc.dart';
import 'package:tmdbflutter/ui/widgets/movies_list.dart';
import 'package:tmdbflutter/utils/app_navigator.dart';

class MoviesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MoviesPage();
}

class _MoviesPage extends State<MoviesPage> {
  final MoviesBloc _moviesBloc = MoviesBloc();

  List<Widget> _moviesList;

  double itemWidth;

  @override
  void initState() {
    super.initState();
  }

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
      backgroundColor: Colors.black,
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
    list.add(MoviesList(
//      itemWidth: itemWidth * 0.85,
      listTitle: "Now Playing",
      moviesStream: _moviesBloc.nowPlayingMovies,
      onMovieClicked: (Movie m) => _onClick(m),
    ));
    list.add(Container(
      height: 20,
    ));
    list.add(MoviesList(
      listTitle: "Popular",
      moviesStream: _moviesBloc.popularMovies,
      onMovieClicked: (Movie m) => _onClick(m),
    ));
    list.add(Container(
      height: 20,
    ));
    list.add(MoviesList(
      listTitle: "Upcoming",
      moviesStream: _moviesBloc.upcomingMovies,
      onMovieClicked: (Movie m) => _onClick(m),
    ));
    list.add(Container(
      height: 20,
    ));
    list.add(MoviesList(
      listTitle: "Top Rated",
      moviesStream: _moviesBloc.topRatedMovies,
      onMovieClicked: (Movie m) => _onClick(m),
    ));
    return list;
  }
}
