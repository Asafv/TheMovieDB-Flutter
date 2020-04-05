import 'package:tmdbflutter/api/tmdb_api.dart';
import 'package:tmdbflutter/models/episode.dart';
import 'package:tmdbflutter/models/genre.dart';
import 'package:tmdbflutter/models/network.dart';
import 'package:tmdbflutter/models/season.dart';

class Tv {
  String backdropPath;
  List<int> episodeRunTime;
  String firstAirDate;
  List<Genre> genres;
  String homepage;
  int id;
  bool inProduction;
  List<String> languages;
  String lastAirDate;
  Episode lastEpisodeToAir;
  String name;
  List<Network> networks;
  Episode nextEpisodeToAir;
  int numberOfEpisodes;
  int numberOfSeasons;
  List<String> originCountry;
  String originalLanguage;
  String originalName;
  String overview;
  double popularity;
  String posterPath;
  List<Network> productionCompanies;
  List<Season> seasons;
  String status;
  String type;
  double voteAverage;
  int voteCount;

  String error;

  Tv(
      {this.backdropPath,
      this.episodeRunTime,
      this.firstAirDate,
      this.genres,
      this.homepage,
      this.id,
      this.inProduction,
      this.languages,
      this.lastAirDate,
      this.lastEpisodeToAir,
      this.name,
      this.networks,
      this.nextEpisodeToAir,
      this.numberOfEpisodes,
      this.numberOfSeasons,
      this.originCountry,
      this.originalLanguage,
      this.originalName,
      this.overview,
      this.popularity,
      this.posterPath,
      this.productionCompanies,
      this.seasons,
      this.status,
      this.type,
      this.voteAverage,
      this.voteCount});

  factory Tv.fromJson(Map<String, dynamic> json) {
    return Tv(
      backdropPath:
          json['backdrop_path'] != null ? json['backdrop_path'] : null,
      episodeRunTime: json['episode_run_time'] != null
          ? new List<int>.from(json['episode_run_time'])
          : null,
      firstAirDate: json['first_air_date'],
      genres: json['genres'] != null
          ? (json['genres'] as List).map((i) => Genre.fromJson(i)).toList()
          : null,
      homepage: json['homepage'],
      id: json['id'],
      inProduction: json['in_production'],
      languages: json['languages'] != null
          ? new List<String>.from(json['languages'])
          : null,
      lastAirDate: json['last_air_date'],
      lastEpisodeToAir: json['last_episode_to_air'] != null
          ? Episode.fromJson(json['last_episode_to_air'])
          : null,
      name: json['name'],
      networks: json['networks'] != null
          ? (json['networks'] as List).map((i) => Network.fromJson(i)).toList()
          : null,
      nextEpisodeToAir: json['next_episode_to_air'] != null
          ? Episode.fromJson(json['next_episode_to_air'])
          : null,
      numberOfEpisodes: json['number_of_episodes'],
      numberOfSeasons: json['number_of_seasons'],
      originCountry: json['origin_country'] != null
          ? new List<String>.from(json['origin_country'])
          : null,
      originalLanguage: json['original_language'],
      originalName: json['original_name'],
      overview: json['overview'],
      popularity: json['popularity'],
      posterPath: json['poster_path'] != null ? json['poster_path'] : null,
      productionCompanies: json['production_companies'] != null
          ? (json['production_companies'] as List)
              .map((i) => Network.fromJson(i))
              .toList()
          : null,
      seasons: json['seasons'] != null
          ? (json['seasons'] as List).map((i) => Season.fromJson(i)).toList()
          : null,
      status: json['status'],
      type: json['type'],
      voteAverage: json['vote_average'].toDouble(),
      voteCount: json['vote_count'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_air_date'] = this.firstAirDate;
    data['homepage'] = this.homepage;
    data['id'] = this.id;
    data['in_production'] = this.inProduction;
    data['last_air_date'] = this.lastAirDate;
    data['name'] = this.name;
    data['number_of_episodes'] = this.numberOfEpisodes;
    data['number_of_seasons'] = this.numberOfSeasons;
    data['original_language'] = this.originalLanguage;
    data['original_name'] = this.originalName;
    data['overview'] = this.overview;
    data['popularity'] = this.popularity;
    data['status'] = this.status;
    data['type'] = this.type;
    data['vote_average'] = this.voteAverage;
    data['vote_count'] = this.voteCount;
    if (this.backdropPath != null) {
      data['backdrop_path'] = this.backdropPath;
    }
    if (this.episodeRunTime != null) {
      data['episode_run_time'] = this.episodeRunTime;
    }
    if (this.genres != null) {
      data['genres'] = this.genres.map((v) => v.toJson()).toList();
    }
    if (this.languages != null) {
      data['languages'] = this.languages;
    }
    if (this.lastEpisodeToAir != null) {
      data['last_episode_to_air'] = this.lastEpisodeToAir.toJson();
    }
    if (this.networks != null) {
      data['networks'] = this.networks.map((v) => v.toJson()).toList();
    }
    if (this.nextEpisodeToAir != null) {
      data['next_episode_to_air'] = this.nextEpisodeToAir.toJson();
    }
    if (this.originCountry != null) {
      data['origin_country'] = this.originCountry;
    }
    if (this.posterPath != null) {
      data['poster_path'] = this.posterPath;
    }
    if (this.productionCompanies != null) {
      data['production_companies'] =
          this.productionCompanies.map((v) => v.toJson()).toList();
    }
    if (this.seasons != null) {
      data['seasons'] = this.seasons.map((v) => v.toJson()).toList();
    }
    return data;
  }

  Tv.withError(String errorValue) : error = errorValue;

  String getPosterUrl(ImageSizes size) {
    return TmdbApi().getImageUrl(this.posterPath, size: size);
  }
}
