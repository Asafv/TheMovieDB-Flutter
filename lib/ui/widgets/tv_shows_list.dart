import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tmdbflutter/models/tv.dart';
import 'package:tmdbflutter/ui/widgets/tv_show_item.dart';

class TvsList extends StatelessWidget {
  final String listTitle;
  final Stream<List<Tv>> tvShowsStream;
  final Function(Tv) onTvClicked;
  final double itemWidth;

  TvsList(
      {@required this.listTitle,
      @required this.tvShowsStream,
      @required this.onTvClicked,
      this.itemWidth = 140});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          child: Text(
            listTitle,
            maxLines: 1,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white),
          ),
        ),
        StreamBuilder<List<Tv>>(
            initialData: List(),
            stream: tvShowsStream,
            builder: (context, snapshot) {
              print("loading movies.. ${snapshot.data}");
              return Container(
                height: 240,
                child: ListView.builder(
                    itemCount: snapshot.data.length,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return TvItem(
                          tv: snapshot.data[index],
                          itemWidth: this.itemWidth,
                          onClick: this.onTvClicked);
                    }),
              );
            }),
      ],
    );
  }
}
