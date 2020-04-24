import 'package:flutter/material.dart';
import 'package:tmdbflutter/models/item_type.dart';
import 'package:tmdbflutter/models/movie.dart';
import 'package:tmdbflutter/ui/details/details_page.dart';
import 'package:tmdbflutter/ui/widgets/list_item.dart';
import 'package:tmdbflutter/utils/app_navigator.dart';

class SearchResults extends StatelessWidget {
  final List<ItemType> items;

  const SearchResults({Key key, this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: .8,
      shrinkWrap: true,
      children: List.generate(items.length, (index) {
        return ListItem(
          item: items[index],
          onClick: (item) {
            if (items[index] is Movie) {
              AppNavigator.goToDetails(context, DetailsType.movie,
                  movie: items[index]);
            } else {
              AppNavigator.goToDetails(context, DetailsType.tv,
                  tv: items[index]);
            }
          },
          itemWidth: 140,
        );
      }, growable: true),
    );
  }
}
