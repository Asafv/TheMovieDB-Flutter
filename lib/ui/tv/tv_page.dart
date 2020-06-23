import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:tmdbflutter/bloc/theme_bloc.dart';
import 'package:tmdbflutter/bloc_provider.dart';
import 'package:tmdbflutter/models/item_type.dart';
import 'package:tmdbflutter/models/tv.dart';
import 'package:tmdbflutter/ui/details/details_page.dart';
import 'package:tmdbflutter/ui/show_more/show_more_bloc.dart';
import 'package:tmdbflutter/ui/tv/tv_bloc.dart';
import 'package:tmdbflutter/ui/widgets/items_list.dart';
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
  void dispose() {
    super.dispose();
    _tvBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _themeBloc = BlocProvider.of<ThemeBloc>(context);
    Fimber.d("_themeBloc: $_themeBloc");

    itemWidth = MediaQuery.of(context).size.width;
    _tvShowsList = _initTvShowsList();

    return Scaffold(
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
    list.add(ItemsList(
//      itemWidth: itemWidth * 0.85,
      listTitle: "On The Air",
      itemsStream: _tvBloc.onTheAirTvs,
      onItemClicked: (ItemType item) => _onClick((item as Tv)),
      onMoreClicked: (List<ItemType> items) =>
          showMorePage(items, ShowMoreTypes.onTheAirTvs),
    ));
    list.add(Container(
      height: 20,
    ));
    list.add(ItemsList(
      listTitle: "Popular",
      itemsStream: _tvBloc.popularTvs,
      onItemClicked: (ItemType item) => _onClick((item as Tv)),
      onMoreClicked: (List<ItemType> items) =>
          showMorePage(items, ShowMoreTypes.popularTvs),
    ));
    list.add(Container(
      height: 20,
    ));
    list.add(ItemsList(
      listTitle: "Top Rated",
      itemsStream: _tvBloc.topRatedTvs,
      onItemClicked: (ItemType item) => _onClick((item as Tv)),
      onMoreClicked: (List<ItemType> items) =>
          showMorePage(items, ShowMoreTypes.topRatedTvs),
    ));
    return list;
  }

  void showMorePage(List<ItemType> items, state) {
    return AppNavigator.showMorePage(context, state, items);
  }

  _onClick(Tv tv) {
    Fimber.d("onClick: ${tv.name}");
    AppNavigator.goToDetails(context, DetailsType.tv, tv: tv);
  }
}
