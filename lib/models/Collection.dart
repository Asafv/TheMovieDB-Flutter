import 'package:tmdbflutter/models/Part.dart';

class Collection {
  String backdrop_path;
  int id;
  String name;
  String overview;
  List<Part> parts;
  Object poster_path;

  Collection(
      {this.backdrop_path,
      this.id,
      this.name,
      this.overview,
      this.parts,
      this.poster_path});

  factory Collection.fromJson(Map<String, dynamic> json) {
    return Collection(
      backdrop_path: json['backdrop_path'],
      id: json['id'],
      name: json['name'],
      overview: json['overview'],
      parts: json['parts'] != null
          ? (json['parts'] as List).map((i) => Part.fromJson(i)).toList()
          : null,
      poster_path: json['poster_path'] != null ? json['poster_path'] : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['backdrop_path'] = this.backdrop_path;
    data['id'] = this.id;
    data['name'] = this.name;
    data['overview'] = this.overview;
    if (this.parts != null) {
      data['parts'] = this.parts.map((v) => v.toJson()).toList();
    }
    if (this.poster_path != null) {
      data['poster_path'] = this.poster_path;
    }
    return data;
  }
}
