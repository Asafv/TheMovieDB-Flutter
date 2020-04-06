import 'package:flutter/material.dart';
import 'package:tmdbflutter/models/movie.dart';
import 'package:tmdbflutter/models/tv.dart';
import 'package:tmdbflutter/ui/details/details_page.dart';

enum NavAction { movies, tvs, details }

class AppNavigator {
  static void navToAction(BuildContext context, NavAction action) {
    switch (action) {
      case NavAction.movies:
        Navigator.pushNamed(context, "/movies_page");
        break;
      case NavAction.tvs:
        Navigator.pushNamed(context, "/tv_page");
        break;
      case NavAction.details:
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

  static void pop(BuildContext context) {
    Navigator.pop(context);
  }
}