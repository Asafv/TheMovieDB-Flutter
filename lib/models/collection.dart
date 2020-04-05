import 'package:tmdbflutter/models/part.dart';

class Collection {
  String backdropPath;
  int id;
  String name;
  String overview;
  List<Part> parts;
  Object posterPath;

  Collection(
      {this.backdropPath,
      this.id,
      this.name,
      this.overview,
      this.parts,
      this.posterPath});

  factory Collection.fromJson(Map<String, dynamic> json) {
    return Collection(
      backdropPath: json['backdrop_path'],
      id: json['id'],
      name: json['name'],
      overview: json['overview'],
      parts: json['parts'] != null
          ? (json['parts'] as List).map((i) => Part.fromJson(i)).toList()
          : null,
      posterPath: json['poster_path'] != null ? json['poster_path'] : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['backdrop_path'] = this.backdropPath;
    data['id'] = this.id;
    data['name'] = this.name;
    data['overview'] = this.overview;
    if (this.parts != null) {
      data['parts'] = this.parts.map((v) => v.toJson()).toList();
    }
    if (this.posterPath != null) {
      data['poster_path'] = this.posterPath;
    }
    return data;
  }
}
