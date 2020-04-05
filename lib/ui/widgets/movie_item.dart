import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tmdbflutter/api/tmdb_api.dart';
import 'package:tmdbflutter/models/movie.dart';

class MovieItem extends StatelessWidget {
  final Movie movie;
  final Function onClick;
  final double itemWidth;

  MovieItem({
    @required this.movie,
    @required this.onClick,
    @required this.itemWidth,
  });

  @override
  Widget build(BuildContext context) {
//    return _getView();
    return InkWell(
      customBorder:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      enableFeedback: true,
      splashColor: Colors.red,
      onTap: () => this.onClick(movie),
      child: Card(
        elevation: 8,
        color: Colors.transparent,
        child: Container(
          color: Colors.transparent,
          width: itemWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: movie.getPosterUrl(ImageSizes.normal),
                  fit: BoxFit.fitWidth,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              Center(
                child: Text(
                  movie.title,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
