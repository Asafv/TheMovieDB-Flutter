class Episode {
  String airDate;
  int episodeNumber;
  int id;
  String name;
  String overview;
  String productionCode;
  int seasonNumber;
  int showId;
  String stillPath;
  double voteAverage;
  int voteCount;

  Episode(
      {this.airDate,
      this.episodeNumber,
      this.id,
      this.name,
      this.overview,
      this.productionCode,
      this.seasonNumber,
      this.showId,
      this.stillPath,
      this.voteAverage,
      this.voteCount});

  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      airDate: json['air_date'],
      episodeNumber: json['episode_number'],
      id: json['id'],
      name: json['name'],
      overview: json['overview'],
      productionCode: json['production_code'],
      seasonNumber: json['season_number'],
      showId: json['show_id'],
      stillPath: json['still_path'] != null ? json['still_path'] : null,
      voteAverage: json['vote_average'],
      voteCount: json['vote_count'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['air_date'] = this.airDate;
    data['episode_number'] = this.episodeNumber;
    data['id'] = this.id;
    data['name'] = this.name;
    data['overview'] = this.overview;
    data['production_code'] = this.productionCode;
    data['season_number'] = this.seasonNumber;
    data['show_id'] = this.showId;
    data['vote_average'] = this.voteAverage;
    data['vote_count'] = this.voteCount;
    if (this.stillPath != null) {
      data['still_path'] = this.stillPath;
    }
    return data;
  }
}
