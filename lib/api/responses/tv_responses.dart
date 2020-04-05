import 'package:tmdbflutter/models/tv.dart';

class TvResponses {
  int page;
  List<Tv> results;
  int totalPages;
  int totalResults;
  String error;

  TvResponses({this.page, this.results, this.totalPages, this.totalResults});

  factory TvResponses.fromJson(Map<String, dynamic> json) {
    return TvResponses(
      page: json['page'],
      results: json['results'] != null
          ? (json['results'] as List).map((i) => Tv.fromJson(i)).toList()
          : null,
      totalPages: json['total_pages'],
      totalResults: json['total_results'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['total_pages'] = this.totalPages;
    data['total_results'] = this.totalResults;
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    return data;
  }

  TvResponses.withError(String errorValue) : error = errorValue;
}
