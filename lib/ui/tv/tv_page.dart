import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:tmdbflutter/models/tv.dart';
import 'package:tmdbflutter/ui/details/details_page.dart';
import 'package:tmdbflutter/ui/tv/tv_bloc.dart';
import 'package:tmdbflutter/ui/widgets/tv_shows_list.dart';
import 'package:tmdbflutter/utils/app_navigator.dart';

class TvPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TvPage();
}

class _TvPage extends State<TvPage> {
  final TvBloc _tvBloc = TvBloc();

  List<Widget> _tvShowsList;
  double itemWidth;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tvBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    itemWidth = MediaQuery.of(context).size.width;
    _tvShowsList = _initTvShowsList();

    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: _tvShowsList,
      ),
    );
  }

  List<Widget> _initTvShowsList() {
    var list = List<Widget>();
    list.add(Container(
      height: 20,
    ));
    list.add(TvsList(
//      itemWidth: itemWidth * 0.85,
      listTitle: "On The Air",
      tvShowsStream: _tvBloc.onTheAirTvs,
      onTvClicked: (Tv tv) => _onClick(tv),
    ));
    list.add(Container(
      height: 20,
    ));
    list.add(TvsList(
      listTitle: "Popular",
      tvShowsStream: _tvBloc.popularTvs,
      onTvClicked: (Tv tv) => _onClick(tv),
    ));
    list.add(Container(
      height: 20,
    ));
    list.add(TvsList(
      listTitle: "Top Rated",
      tvShowsStream: _tvBloc.topRatedTvs,
      onTvClicked: (Tv tv) => _onClick(tv),
    ));
    return list;
  }

  _onClick(Tv tv) {
    Fimber.d("onClick: ${tv.name}");
    AppNavigator.goToDetails(context, DetailsType.tv, tv: tv);
  }
}
