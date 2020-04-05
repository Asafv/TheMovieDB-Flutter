import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tmdbflutter/models/movie.dart';
import 'package:tmdbflutter/ui/widgets/movie_item.dart';

class MoviesList extends StatelessWidget {
  final String listTitle;
  final Stream<List<Movie>> moviesStream;
  final Function(Movie) onMovieClicked;
  final double itemWidth;

  MoviesList(
      {@required this.listTitle,
      @required this.moviesStream,
      @required this.onMovieClicked,
      this.itemWidth = 140});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: Text(
                listTitle,
                maxLines: 1,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.white),
              ),
            ),
            FlatButton(
              splashColor: Colors.green,
              onPressed: () {
                print("flatbutton press");
              },
              child: Text(
                "MORE",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
        StreamBuilder<List<Movie>>(
            initialData: List(),
            stream: moviesStream,
            builder: (context, snapshot) {
              print("loading movies.. ${snapshot.data}");
              return Container(
                height: 240,
                child: ListView.builder(
                    itemCount: snapshot.data.length,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return MovieItem(
                          movie: snapshot.data[index],
                          itemWidth: this.itemWidth,
                          onClick: this.onMovieClicked);
                    }),
              );
            }),
      ],
    );
  }
}
