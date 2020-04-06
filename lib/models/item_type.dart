import 'package:tmdbflutter/api/tmdb_api.dart';

abstract class ItemType {
  String getPosterUrl(ImageSizes size);
}
