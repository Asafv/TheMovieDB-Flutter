class Episode {
  String air_date;
  int episode_number;
  int id;
  String name;
  String overview;
  String production_code;
  int season_number;
  int show_id;
  String still_path;
  double vote_average;
  int vote_count;

  Episode(
      {this.air_date,
      this.episode_number,
      this.id,
      this.name,
      this.overview,
      this.production_code,
      this.season_number,
      this.show_id,
      this.still_path,
      this.vote_average,
      this.vote_count});

  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      air_date: json['air_date'],
      episode_number: json['episode_number'],
      id: json['id'],
      name: json['name'],
      overview: json['overview'],
      production_code: json['production_code'],
      season_number: json['season_number'],
      show_id: json['show_id'],
      still_path: json['still_path'] != null ? json['still_path'] : null,
      vote_average: json['vote_average'],
      vote_count: json['vote_count'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['air_date'] = this.air_date;
    data['episode_number'] = this.episode_number;
    data['id'] = this.id;
    data['name'] = this.name;
    data['overview'] = this.overview;
    data['production_code'] = this.production_code;
    data['season_number'] = this.season_number;
    data['show_id'] = this.show_id;
    data['vote_average'] = this.vote_average;
    data['vote_count'] = this.vote_count;
    if (this.still_path != null) {
      data['still_path'] = this.still_path;
    }
    return data;
  }
}
