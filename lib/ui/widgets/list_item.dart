import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tmdbflutter/api/tmdb_api.dart';
import 'package:tmdbflutter/models/item_type.dart';
import 'package:tmdbflutter/models/movie.dart';
import 'package:tmdbflutter/models/tv.dart';
import 'package:tmdbflutter/utils/theme_utils.dart';

class ListItem extends StatelessWidget {
  final ItemType item;
  final Function onClick;
  final double itemWidth;

  ListItem({
    @required this.item,
    @required this.onClick,
    @required this.itemWidth,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      enableFeedback: true,
      splashColor: ThemeUtils.splashColor,
      onTap: () => this.onClick(item),
      child: Card(
        elevation: 3,
        child: Container(
          color: Colors.transparent,
          width: itemWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: CachedNetworkImage(
                  imageUrl: item.getPosterUrl(ImageSizes.normal),
                  fit: BoxFit.fitWidth,
                  height: 200,
                  width: itemWidth,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    item is Movie ? (item as Movie).title : (item as Tv).name,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
