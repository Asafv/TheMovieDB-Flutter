import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tmdbflutter/data/api/tmdb_api.dart';
import 'package:tmdbflutter/models/tv.dart';

const double _imageHeight = 260;

class TvDetails extends StatelessWidget {
  final Tv tv;

  TvDetails({@required this.tv});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _itemImageTile(),
              _itemDetails(),
            ],
          ),
          Container(
            child: Text(
              "Details Page",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Container _itemImageTile() {
    // TODO: when click show backdrop path poster
    return Container(
      child: CachedNetworkImage(
        imageUrl: tv.getPosterUrl(ImageSizes.normal),
        fit: BoxFit.fitWidth,
        height: _imageHeight,
        placeholder: (context, url) => Container(
            height: _imageHeight,
            child: Center(
              child: CircularProgressIndicator(),
            )),
        errorWidget: (context, url, error) => Container(
          height: _imageHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.error,
                color: Colors.red,
              ),
              Text(
                "Image\nNot Found",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.redAccent),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container _itemDetails() {
    final rating = "${tv.voteAverage}/10 (${tv.voteCount})";
    return Container(
      child: Column(
        children: <Widget>[
          Text("Rating: $rating"),
          Text("Release: $rating"),
          Text("Rating: $rating"),
        ],
      ),
    );
  }
}
