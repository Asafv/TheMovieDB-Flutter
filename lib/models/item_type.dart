import 'package:tmdbflutter/data/api/tmdb_api.dart';

abstract class ItemType {
  String getPosterUrl(ImageSizes size);
}
