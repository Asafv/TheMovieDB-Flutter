import 'package:cached_network_image/cached_network_image.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tmdbflutter/data/api/tmdb_api.dart';
import 'package:tmdbflutter/models/item_type.dart';
import 'package:tmdbflutter/models/movie.dart';
import 'package:tmdbflutter/models/tv.dart';
import 'package:tmdbflutter/ui/details/details_bloc.dart';

enum DetailsType { movie, tv }

const double _imageHeight = 260;

// ignore: must_be_immutable
class DetailsPage extends StatefulWidget {
  final DetailsType type;
  Movie movie;
  Tv tv;

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

  ItemType getItem() =>
      widget.type == DetailsType.movie ? widget.movie : widget.tv;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(getItem().getTitle())),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            /// keeping the image in the same hierarchy for Hero animation
            FutureBuilder(
                initialData: null,
                future: widget.type == DetailsType.movie
                    ? _detailsBloc.getMovieDetails(widget.movie.id)
                    : _detailsBloc.getTvDetails(widget.tv.id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      child: Center(
                        child: LinearProgressIndicator(),
                      ),
                    );
                  }
                  Fimber.d(
                      "FutureBuilder, snapshot: ${snapshot.data.toString()}");
                  widget.type == DetailsType.movie
                      ? widget.movie = snapshot.data
                      : widget.tv = snapshot.data;

                  return _detailColumn();
                }),
            Positioned(top: 10, left: 10, child: _itemImageTile()),
          ],
        ),
      ),
    );
  }

  Widget _itemImageTile() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Hero(
        tag: getItem().getTag(),
        child: Container(
          child: CachedNetworkImage(
            imageUrl: getItem().getPosterUrl(ImageSizes.normal),
            fit: BoxFit.fitWidth,
            height: _imageHeight * 0.7,
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
      ),
    );
  }

  Widget _detailColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Stack(
          children: <Widget>[
            _backdropPoster(),
            Container(
              margin: EdgeInsets.only(top: _imageHeight - 50),
              child: Expanded(child: _itemDetails(getItem())),
            )
          ],
        ),
        _buildDivider(),
        _overview(),
        _buildDivider(),
        Container(
          child: Padding(
            padding: textPadding(),
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
        imageUrl: getItem().getBackdropPoster(),
        fit: BoxFit.fitHeight,
        height: _imageHeight,
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

  Widget _itemDetails(ItemType item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: textPadding(),
          child: Text(
            "${item.getRating()}",
            textAlign: TextAlign.center,
            style:
                _headerTextStyle(fontSize: 30, fontColor: item.getVoteColor()),
          ),
        ),
        Padding(
          padding: textPadding(),
          child: Text(
            "Status: ${getItem().getStatus()}",
            style: _headerTextStyle(),
          ),
        ),
        Padding(
          padding: textPadding(),
          child: Text(
            "Release: ${item.getReleaseDate()}",
            style: _headerTextStyle(),
          ),
        ),
        Padding(
          padding: textPadding(),
          child: Text(
            "Duration: ${item.getRuntime()}",
            style: _headerTextStyle(),
          ),
        ),
        (getItem() is Movie)
            ? Padding(
                padding: textPadding(),
                child: Text(
                  "Budget: \$${widget.movie.budget}",
                  style: _headerTextStyle(),
                ),
              )
            : Padding(
                padding: textPadding(),
                child: Text(
                  "Seasons: ${widget.tv.numberOfSeasons}",
                  style: _headerTextStyle(),
                ),
              ),
        (getItem() is Movie)
            ? Padding(
                padding: textPadding(),
                child: Text(
                  "Revenue: \$${widget.movie.revenue}",
                  style: _headerTextStyle(),
                ),
              )
            : Padding(
                padding: textPadding(),
                child: Text(
                  "Episodes: ${widget.tv.numberOfEpisodes}",
                  style: _headerTextStyle(),
                ),
              ),
      ],
    );
  }

  Widget _buildDivider() {
    return Divider(
      color: getItem().getVoteColor(),
      height: 25,
      indent: 10,
      endIndent: 10,
      thickness: 2,
    );
  }

  EdgeInsets textPadding() => const EdgeInsets.all(6.0);

  TextStyle _headerTextStyle({double fontSize = 20, Color fontColor}) =>
      TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
          color: fontColor);

  Widget _overview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: textPadding(),
          child: Text(
            "Overview",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.start,
          ),
        ),
        Padding(
          padding: textPadding(),
          child: Text(
            getItem().getOverview(),
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.start,
          ),
        )
      ],
    );
  }
}
