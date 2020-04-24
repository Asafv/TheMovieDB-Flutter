import 'package:tmdbflutter/models/video.dart';

class VideoResponse {
  int id;
  List<Video> results;
  String error;

  VideoResponse({this.id, this.results});

  factory VideoResponse.fromJson(Map<String, dynamic> json) {
    return VideoResponse(
      id: json['id'],
      results: json['results'] != null
          ? (json['results'] as List).map((i) => Video.fromJson(i)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    return data;
  }

  VideoResponse.withError(String errorValue) : error = errorValue;
}
