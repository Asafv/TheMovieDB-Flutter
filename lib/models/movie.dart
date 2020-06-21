import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tmdbflutter/data/api/tmdb_api.dart';
import 'package:tmdbflutter/models/collection.dart';
import 'package:tmdbflutter/models/genre.dart';
import 'package:tmdbflutter/models/item_type.dart';
import 'package:tmdbflutter/models/network.dart';
import 'package:tmdbflutter/models/production_country.dart';
import 'package:tmdbflutter/models/spoken_language.dart';
import 'package:uuid/uuid.dart';

class Movie implements ItemType {
  bool adult;
  String backdropPath;
  Object belongsToCollection;
  int budget;
  List<Genre> genres;
  String homepage;
  int id;
  String imdbId;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String posterPath;
  List<Network> productionCompanies;
  List<ProductionCountry> productionCountries;
  String releaseDate;
  int revenue;
  int runtime;
  List<SpokenLanguage> spokenLanguages;
  String status;
  String tagline;
  String title;
  bool video;
  double voteAverage;
  int voteCount;

  String error;
  String tag = Uuid().v4();

  Movie(
      {this.adult,
      this.backdropPath,
      this.belongsToCollection,
      this.budget,
      this.genres,
      this.homepage,
      this.id,
      this.imdbId,
      this.originalLanguage,
      this.originalTitle,
      this.overview,
      this.popularity,
      this.posterPath,
      this.productionCompanies,
      this.productionCountries,
      this.releaseDate,
      this.revenue,
      this.runtime,
      this.spokenLanguages,
      this.status,
      this.tagline,
      this.title,
      this.video,
      this.voteAverage,
      this.voteCount});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      adult: json['adult'],
      backdropPath: json['backdrop_path'],
      belongsToCollection: json['belongs_to_collection'] != null
          ? Collection.fromJson(json['belongs_to_collection'])
          : null,
      budget: json['budget'],
      genres: json['genres'] != null
          ? (json['genres'] as List).map((i) => Genre.fromJson(i)).toList()
          : null,
      homepage: json['homepage'],
      id: json['id'],
      imdbId: json['imdb_id'],
      originalLanguage: json['original_language'],
      originalTitle: json['original_title'],
      overview: json['overview'],
      popularity: json['popularity'].toDouble(),
      posterPath: json['poster_path'],
      productionCompanies: json['production_companies'] != null
          ? (json['production_companies'] as List)
              .map((i) => Network.fromJson(i))
              .toList()
          : null,
      productionCountries: json['production_countries'] != null
          ? (json['production_countries'] as List)
              .map((i) => ProductionCountry.fromJson(i))
              .toList()
          : null,
      releaseDate: json['release_date'],
      revenue: json['revenue'],
      runtime: json['runtime'],
      spokenLanguages: json['spoken_languages'] != null
          ? (json['spoken_languages'] as List)
              .map((i) => SpokenLanguage.fromJson(i))
              .toList()
          : null,
      status: json['status'],
      tagline: json['tagline'],
      title: json['title'],
      video: json['video'],
      voteAverage: json['vote_average'].toDouble(),
      voteCount: json['vote_count'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['adult'] = this.adult;
    data['backdrop_path'] = this.backdropPath;
    data['budget'] = this.budget;
    data['homepage'] = this.homepage;
    data['id'] = this.id;
    data['imdb_id'] = this.imdbId;
    data['original_language'] = this.originalLanguage;
    data['original_title'] = this.originalTitle;
    data['overview'] = this.overview;
    data['popularity'] = this.popularity;
    data['poster_path'] = this.posterPath;
    data['release_date'] = this.releaseDate;
    data['revenue'] = this.revenue;
    data['runtime'] = this.runtime;
    data['status'] = this.status;
    data['tagline'] = this.tagline;
    data['title'] = this.title;
    data['video'] = this.video;
    data['vote_average'] = this.voteAverage;
    data['vote_count'] = this.voteCount;
    if (this.belongsToCollection != null) {
      data['belongs_to_collection'] = this.belongsToCollection;
    }
    if (this.genres != null) {
      data['genres'] = this.genres.map((v) => v.toJson()).toList();
    }
    if (this.productionCompanies != null) {
      data['production_companies'] =
          this.productionCompanies.map((v) => v.toJson()).toList();
    }
    if (this.productionCountries != null) {
      data['production_countries'] =
          this.productionCountries.map((v) => v.toJson()).toList();
    }
    if (this.spokenLanguages != null) {
      data['spoken_languages'] =
          this.spokenLanguages.map((v) => v.toJson()).toList();
    }
    return data;
  }

  Movie.withError(String errorValue) : error = errorValue;

  @override
  String getPosterUrl(ImageSizes size) {
//    Fimber.d("${this.title} -(posterPath): ${this.posterPath}");
//    Fimber.d("${this.title} -(backdropPath): ${this.backdropPath}");
    return TmdbApi().getImageUrl(this.posterPath, size: size);
  }

  @override
  String toString() {
    return "Movie: $title, $posterPath";
  }

  @override
  String getTag() {
    return this.tag;
  }

  @override
  String getTitle() {
    return this.title;
  }

  @override
  String getBackdropPoster() {
    return TmdbApi().getImageUrl(this.backdropPath, size: ImageSizes.normal);
  }

  @override
  String getRating() {
    return "${this.voteAverage}/10 (${this.voteCount})";
  }

  @override
  Color getVoteColor() {
    return this.voteAverage >= 6 ? Colors.lightGreen[900] : Colors.red;
  }

  @override
  String getOverview() {
    return this.overview;
  }

  @override
  String getReleaseDate() {
    return this.releaseDate;
  }

  @override
  String getRuntime() {
    return "${this.runtime} minutes";
  }

  @override
  String getStatus() {
    return this.status;
  }
}
