import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tmdbflutter/bloc/search/search_bloc.dart';
import 'package:tmdbflutter/bloc/search/search_event.dart';
import 'package:tmdbflutter/ui/details/details_page.dart';
import 'package:tmdbflutter/ui/search/search_body_widget.dart';

class SearchPage extends StatefulWidget {
  final DetailsType type;

  SearchPage({@required this.type});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  SearchBloc _searchBloc;
  final textChangeSubject = PublishSubject<String>();
  TextEditingController _searchQueryController = TextEditingController();

  bool _isSearching = false;
  String searchQuery = "";

  @override
  void didChangeDependencies() {
    Fimber.d("didChangeDependencies");
    super.didChangeDependencies();
    _searchBloc = BlocProvider.of<SearchBloc>(context);

    textChangeSubject
        .distinct()
        .debounceTime(Duration(milliseconds: 400))
        .listen((text) =>
            _searchBloc.add(TextChanged(text: text, type: widget.type)));
  }

  @override
  void dispose() {
    textChangeSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _buildSearchField(),
        actions: _isSearching ? _buildActions() : [Container()],
      ),
      body: Column(
        children: [SearchBody()],
      ),
    );
  }

  void updateSearchQuery(String newQuery) {
    setState(() {
      _isSearching = newQuery.isNotEmpty;
      textChangeSubject.sink.add(newQuery);
    });
  }

  void _clearSearchQuery() {
    setState(() {
      _searchQueryController.clear();
      updateSearchQuery("");
    });
  }

  _buildActions() {
    return <Widget>[
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          _clearSearchQuery();
        },
      ),
    ];
  }

  _buildSearchField() {
    return TextField(
      controller: _searchQueryController,
      autofocus: true,
      cursorColor: Colors.green,
      decoration: InputDecoration(
        hintText:
            "Search ${widget.type == DetailsType.movie ? 'Movies' : 'Tv Shows'}",
        border: InputBorder.none,
      ),
      onChanged: (query) => updateSearchQuery(query),
    );
  }
}
