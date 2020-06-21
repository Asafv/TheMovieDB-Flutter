import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tmdbflutter/bloc_provider.dart';
import 'package:tmdbflutter/models/item_type.dart';
import 'package:tmdbflutter/ui/show_more/show_more_bloc.dart';
import 'package:tmdbflutter/ui/show_more/show_more_result_widget.dart';

class ShowMorePage extends StatefulWidget {
  final ShowMoreState state;
  final List<ItemType> items;

  ShowMorePage({@required this.items, @required this.state});

  @override
  State<StatefulWidget> createState() => _ShowMorePage();
}

class _ShowMorePage extends State<ShowMorePage> {
  ShowMoreBloc _showMoreBloc;

  @override
  void initState() {
    _showMoreBloc = ShowMoreBloc(widget.state);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_showMoreBloc.getTitle())),
      body: BlocProvider<ShowMoreBloc>(
        bloc: _showMoreBloc,
        child: StreamBuilder<List<ItemType>>(
            initialData: widget.items,
            stream: _showMoreBloc.itemsStream,
            builder: (context, snapshot) {
              return ShowMoreResults(items: snapshot.data);
            }),
      ),
    );
  }
}
