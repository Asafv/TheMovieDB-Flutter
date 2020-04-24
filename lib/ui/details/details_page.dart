import 'package:fimber/fimber.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tmdbflutter/models/movie.dart';
import 'package:tmdbflutter/models/tv.dart';
import 'package:tmdbflutter/ui/details/details_bloc.dart';
import 'package:tmdbflutter/ui/widgets/movie_details.dart';
import 'package:tmdbflutter/ui/widgets/tv_details.dart';

enum DetailsType { movie, tv }

const double _imageHeight = 260;

class DetailsPage extends StatefulWidget {
  final DetailsType type;
  final Movie movie;
  final Tv tv;

  DetailsPage({@required this.type, this.movie, this.tv});

  @override
  State<StatefulWidget> createState() => _DetailsPage();
}

class _DetailsPage extends State<DetailsPage> {
  final DetailsBloc _detailsBloc = DetailsBloc();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _detailsBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final title =
        widget.type == DetailsType.movie ? widget.movie.title : widget.tv.name;

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: FutureBuilder(
          initialData: null,
          future: widget.type == DetailsType.movie
              ? _detailsBloc.getMovieDetails(widget.movie.id)
              : _detailsBloc.getTvDetails(widget.tv.id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            Fimber.d("FutureBuilder, snapshot: ${snapshot.data.toString()}");
            return widget.type == DetailsType.movie
                ? MovieDetails(movie: snapshot.data)
                : TvDetails(tv: snapshot.data);
          }),
    );
  }
}
