import 'package:tmdbflutter/data/api/tmdb_api.dart';

abstract class ItemType {
  String getTitle();
  String getPosterUrl(ImageSizes size);
  String getBackdropPoster();
  String getTag();
}
