import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tmdbflutter/data/api/tmdb_api.dart';
import 'package:tmdbflutter/models/movie.dart';

const double _imageHeight = 260;

class MovieDetails extends StatelessWidget {
  final Movie movie;

  MovieDetails({@required this.movie});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _itemImageTile(),
              _itemDetails(),
            ],
          ),
          _buildDivider(),
          _overview(),
          _buildDivider(),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Videos",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
            ),
          ),
//          _buildDivider(),
//          Container(
//            child: Text(
//              "Casts",
//              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//              textAlign: TextAlign.center,
//            ),
//          )
        ],
      ),
    );
  }

  Divider _buildDivider() {
    return Divider(
      color: Colors.green,
      height: 25,
      indent: 10,
      endIndent: 10,
      thickness: 1,
    );
  }

  Container _itemImageTile() {
    // TODO: when click show backdrop path poster
    return Container(
      child: CachedNetworkImage(
        imageUrl: movie.getPosterUrl(ImageSizes.normal),
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

  Widget _itemDetails() {
    final rating = "${movie.voteAverage}/10 (${movie.voteCount})";
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "$rating",
            style: TextStyle(fontSize: 22),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Status: ${movie.status}"),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Release: ${movie.releaseDate}"),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Duration: ${movie.runtime} min."),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Budget: \$${movie.budget}"),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Revenue: \$${movie.revenue}"),
        ),
      ],
    );
  }

  Widget _overview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Overview",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.start,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            movie.overview,
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.start,
          ),
        )
      ],
    );
  }
}
