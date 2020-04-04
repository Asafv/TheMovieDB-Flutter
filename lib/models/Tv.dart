import 'package:tmdbflutter/models/Episode.dart';
import 'package:tmdbflutter/models/Genre.dart';
import 'package:tmdbflutter/models/Network.dart';
import 'package:tmdbflutter/models/Season.dart';

class Tv {
  String backdrop_path;
  List<int> episode_run_time;
  String first_air_date;
  List<Genre> genres;
  String homepage;
  int id;
  bool in_production;
  List<String> languages;
  String last_air_date;
  Episode last_episode_to_air;
  String name;
  List<Network> networks;
  Episode next_episode_to_air;
  int number_of_episodes;
  int number_of_seasons;
  List<String> origin_country;
  String original_language;
  String original_name;
  String overview;
  double popularity;
  String poster_path;
  List<Network> production_companies;
  List<Season> seasons;
  String status;
  String type;
  double vote_average;
  int vote_count;

  Tv(
      {this.backdrop_path,
      this.episode_run_time,
      this.first_air_date,
      this.genres,
      this.homepage,
      this.id,
      this.in_production,
      this.languages,
      this.last_air_date,
      this.last_episode_to_air,
      this.name,
      this.networks,
      this.next_episode_to_air,
      this.number_of_episodes,
      this.number_of_seasons,
      this.origin_country,
      this.original_language,
      this.original_name,
      this.overview,
      this.popularity,
      this.poster_path,
      this.production_companies,
      this.seasons,
      this.status,
      this.type,
      this.vote_average,
      this.vote_count});

  factory Tv.fromJson(Map<String, dynamic> json) {
    return Tv(
      backdrop_path:
          json['backdrop_path'] != null ? json['backdrop_path'] : null,
      episode_run_time: json['episode_run_time'] != null
          ? new List<int>.from(json['episode_run_time'])
          : null,
      first_air_date: json['first_air_date'],
      genres: json['genres'] != null
          ? (json['genres'] as List).map((i) => Genre.fromJson(i)).toList()
          : null,
      homepage: json['homepage'],
      id: json['id'],
      in_production: json['in_production'],
      languages: json['languages'] != null
          ? new List<String>.from(json['languages'])
          : null,
      last_air_date: json['last_air_date'],
      last_episode_to_air: json['last_episode_to_air'] != null
          ? Episode.fromJson(json['last_episode_to_air'])
          : null,
      name: json['name'],
      networks: json['networks'] != null
          ? (json['networks'] as List).map((i) => Network.fromJson(i)).toList()
          : null,
      next_episode_to_air: json['next_episode_to_air'] != null
          ? Episode.fromJson(json['next_episode_to_air'])
          : null,
      number_of_episodes: json['number_of_episodes'],
      number_of_seasons: json['number_of_seasons'],
      origin_country: json['origin_country'] != null
          ? new List<String>.from(json['origin_country'])
          : null,
      original_language: json['original_language'],
      original_name: json['original_name'],
      overview: json['overview'],
      popularity: json['popularity'],
      poster_path: json['poster_path'] != null ? json['poster_path'] : null,
      production_companies: json['production_companies'] != null
          ? (json['production_companies'] as List)
              .map((i) => Network.fromJson(i))
              .toList()
          : null,
      seasons: json['seasons'] != null
          ? (json['seasons'] as List).map((i) => Season.fromJson(i)).toList()
          : null,
      status: json['status'],
      type: json['type'],
      vote_average: json['vote_average'],
      vote_count: json['vote_count'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_air_date'] = this.first_air_date;
    data['homepage'] = this.homepage;
    data['id'] = this.id;
    data['in_production'] = this.in_production;
    data['last_air_date'] = this.last_air_date;
    data['name'] = this.name;
    data['number_of_episodes'] = this.number_of_episodes;
    data['number_of_seasons'] = this.number_of_seasons;
    data['original_language'] = this.original_language;
    data['original_name'] = this.original_name;
    data['overview'] = this.overview;
    data['popularity'] = this.popularity;
    data['status'] = this.status;
    data['type'] = this.type;
    data['vote_average'] = this.vote_average;
    data['vote_count'] = this.vote_count;
    if (this.backdrop_path != null) {
      data['backdrop_path'] = this.backdrop_path;
    }
    if (this.episode_run_time != null) {
      data['episode_run_time'] = this.episode_run_time;
    }
    if (this.genres != null) {
      data['genres'] = this.genres.map((v) => v.toJson()).toList();
    }
    if (this.languages != null) {
      data['languages'] = this.languages;
    }
    if (this.last_episode_to_air != null) {
      data['last_episode_to_air'] = this.last_episode_to_air.toJson();
    }
    if (this.networks != null) {
      data['networks'] = this.networks.map((v) => v.toJson()).toList();
    }
    if (this.next_episode_to_air != null) {
      data['next_episode_to_air'] = this.next_episode_to_air.toJson();
    }
    if (this.origin_country != null) {
      data['origin_country'] = this.origin_country;
    }
    if (this.poster_path != null) {
      data['poster_path'] = this.poster_path;
    }
    if (this.production_companies != null) {
      data['production_companies'] =
          this.production_companies.map((v) => v.toJson()).toList();
    }
    if (this.seasons != null) {
      data['seasons'] = this.seasons.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
