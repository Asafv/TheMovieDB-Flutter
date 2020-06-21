import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tmdbflutter/models/tv.dart';

const double _imageHeight = 260;

class TvDetails extends StatelessWidget {
  final Tv tv;

  TvDetails({@required this.tv});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Stack(
          children: <Widget>[
            Opacity(
              opacity: 0.4,
              child: CachedNetworkImage(
                fadeInCurve: Curves.linear,
                imageUrl: tv.getBackdropPoster(),
                fit: BoxFit.fitHeight,
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
            ),
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

  Divider _buildDivider() {
    return Divider(
      color: Colors.green,
      height: 25,
      indent: 10,
      endIndent: 10,
      thickness: 1,
    );
  }

  Widget _itemDetails() {
    final rating = "${tv.voteAverage}/10 (${tv.voteCount})";
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
          child: Text(
            "Status: ${tv.status}",
            style: TextStyle(fontSize: 18),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Release: ${tv.firstAirDate}",
            style: TextStyle(fontSize: 18),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Seasons: ${tv.numberOfSeasons}",
            style: TextStyle(fontSize: 18),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Episodes: ${tv.numberOfEpisodes}",
            style: TextStyle(fontSize: 18),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Next Episode Release: ${tv.nextEpisodeToAir != null ? tv.nextEpisodeToAir.airDate : 'unknown'}",
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
            tv.overview,
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.start,
          ),
        )
      ],
    );
  }
}
