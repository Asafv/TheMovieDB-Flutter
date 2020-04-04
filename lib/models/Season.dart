class Season {
  String air_date;
  int episode_count;
  int id;
  String name;
  String overview;
  String poster_path;
  int season_number;

  Season(
      {this.air_date,
      this.episode_count,
      this.id,
      this.name,
      this.overview,
      this.poster_path,
      this.season_number});

  factory Season.fromJson(Map<String, dynamic> json) {
    return Season(
      air_date: json['air_date'],
      episode_count: json['episode_count'],
      id: json['id'],
      name: json['name'],
      overview: json['overview'],
      poster_path: json['poster_path'] != null ? json['poster_path'] : null,
      season_number: json['season_number'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['air_date'] = this.air_date;
    data['episode_count'] = this.episode_count;
    data['id'] = this.id;
    data['name'] = this.name;
    data['overview'] = this.overview;
    data['season_number'] = this.season_number;
    if (this.poster_path != null) {
      data['poster_path'] = this.poster_path;
    }
    return data;
  }
}
