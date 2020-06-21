import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tmdbflutter/models/item_type.dart';
import 'package:tmdbflutter/ui/widgets/list_item.dart';

class ItemsList extends StatelessWidget {
  final String listTitle;
  final Stream<List<ItemType>> itemsStream;
  final Function(ItemType) onItemClicked;
  final double itemWidth;

  ItemsList({
    @required this.listTitle,
    @required this.itemsStream,
    @required this.onItemClicked,
    this.itemWidth = 155,
  });

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
              margin: EdgeInsets.all(8),
              child: Text(
                listTitle,
                maxLines: 1,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
            ),
            FlatButton(
              splashColor: Colors.green,
              onPressed: () {
                print("flatbutton press");
              },
              child: Text("MORE"),
            )
          ],
        ),
        StreamBuilder<List<ItemType>>(
            initialData: List(),
            stream: itemsStream,
            builder: (context, snapshot) {
              print("loading movies.. ${snapshot.data}");
              return Container(
                height: 260,
                child: ListView.builder(
                    itemCount: snapshot.data.length,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ListItem(
                        item: snapshot.data[index],
                        itemWidth: this.itemWidth,
                        onClick: this.onItemClicked,
                      );
                    }),
              );
            }),
      ],
    );
  }
}
