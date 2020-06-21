import 'package:flutter/material.dart';
import 'package:tmdbflutter/data/api/tmdb_api.dart';

abstract class ItemType {
  String getTag();
  String getTitle();
  String getPosterUrl(ImageSizes size);
  String getBackdropPoster();
  String getRating();
  Color getVoteColor();
  String getStatus();
  String getReleaseDate();
  String getRuntime();
  String getOverview();
}
