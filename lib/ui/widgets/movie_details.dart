import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tmdbflutter/models/movie.dart';

const double _imageHeight = 260;

class MovieDetails extends StatelessWidget {
  final Movie movie;

  MovieDetails({@required this.movie});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Stack(
          children: <Widget>[
            _backdropPoster(),
            Container(
              margin: EdgeInsets.only(top: 100),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      height: _imageHeight,
                    ),
                  ),
                  Expanded(child: _itemDetails()),
                ],
              ),
            )
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
    );
  }

  Opacity _backdropPoster() {
    return Opacity(
      opacity: 0.4,
      child: CachedNetworkImage(
        fadeInCurve: Curves.linear,
        imageUrl: movie.getBackdropPoster(),
        fit: BoxFit.fitHeight,
        height: _imageHeight,
        placeholder: (context, url) => Container(
            height: _imageHeight,
            child: Center(
              child: CircularProgressIndicator(),
            )),
        errorWidget: (context, url, error) => Container(
          height: _imageHeight,
          child: Center(
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
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      color: Colors.green,
      height: 25,
      indent: 10,
      endIndent: 10,
      thickness: 1,
    );
  }

  Widget _itemDetails() {
    final rating = "${movie.voteAverage}/10 (${movie.voteCount})";
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
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
          child: Text(
            "Status: ${movie.status}",
            style: TextStyle(fontSize: 18),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Release: ${movie.releaseDate}",
            style: TextStyle(fontSize: 18),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Duration: ${movie.runtime} min.",
            style: TextStyle(fontSize: 18),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Budget: \$${movie.budget}",
            style: TextStyle(fontSize: 18),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Revenue: \$${movie.revenue}",
            style: TextStyle(fontSize: 18),
          ),
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
