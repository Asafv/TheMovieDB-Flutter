import 'package:tmdbflutter/data/tmdb_repository.dart';
import 'package:tmdbflutter/models/item_type.dart';

class DetailsBloc {
  final _tmdbRepo = TmdbRepository();

  void dispose() {}

  Future<ItemType> getMovieDetails(int id) async {
    return await _tmdbRepo.getMovieById(id);
  }

  Future<ItemType> getTvDetails(int id) async {
    return await _tmdbRepo.getTvById(id);
  }
}
