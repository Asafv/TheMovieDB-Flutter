import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdbflutter/bloc/search/search_bloc.dart';
import 'package:tmdbflutter/models/item_type.dart';
import 'package:tmdbflutter/models/movie.dart';
import 'package:tmdbflutter/models/tv.dart';
import 'package:tmdbflutter/ui/details/details_page.dart';
import 'package:tmdbflutter/ui/search/search_page.dart';
import 'package:tmdbflutter/ui/show_more/show_more_bloc.dart';
import 'package:tmdbflutter/ui/show_more/show_more_page.dart';

enum NavAction { movies, tvs }

class AppNavigator {
  static void navToAction(BuildContext context, NavAction action) {
    switch (action) {
      case NavAction.movies:
        Navigator.pushNamed(context, "/movies_page");
        break;
      case NavAction.tvs:
        Navigator.pushNamed(context, "/tv_page");
        break;
    }
  }

  static void goToDetails(BuildContext context, DetailsType type,
      {Movie movie, Tv tv}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailsPage(
          type: type,
          movie: movie,
          tv: tv,
        ),
      ),
    );
//    Navigator.pushNamed(context, "/details_page", arguments: movie);
  }

  static void showMorePage(
      BuildContext context, ShowMoreTypes state, List<ItemType> items) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ShowMorePage(
          state: state,
          items: items,
        ),
      ),
    );
//    Navigator.pushNamed(context, "/details_page", arguments: movie);
  }

  static void pop(BuildContext context) {
    Navigator.pop(context);
  }

//
  static goToSearch(BuildContext context, DetailsType type) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => SearchBloc(),
          child: SearchPage(type: type),
        ),
      ),
    );
  }
}
