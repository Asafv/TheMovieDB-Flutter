import 'package:tmdbflutter/models/genre.dart';

class GenresResponse {
  List<Genre> genres;
  String error;

  GenresResponse({this.genres});

  factory GenresResponse.fromJson(Map<String, dynamic> json) {
    return GenresResponse(
      genres: json['genres'] != null
          ? (json['genres'] as List).map((i) => Genre.fromJson(i)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.genres != null) {
      data['genres'] = this.genres.map((v) => v.toJson()).toList();
    }
    return data;
  }

  GenresResponse.withError(String errorValue) : error = errorValue;
}
