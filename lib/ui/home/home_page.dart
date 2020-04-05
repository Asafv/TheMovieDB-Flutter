import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tmdbflutter/ui/movies/movies_page.dart';
import 'package:tmdbflutter/ui/tv/tv_page.dart';
import 'package:tmdbflutter/utils/prefs.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  Prefs _prefs = Prefs();
  Widget _loadingPage = MoviesPage();
  String _appBarTitle = "Movies";

  void _select(Choice choice) async {
    await _prefs.saveString(Prefs.K_LAST_SELECTED_PAGE, choice.title);
    _lastSelectedPage();
  }

  @override
  void initState() {
    super.initState();
    _lastSelectedPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_appBarTitle),
          actions: <Widget>[
            PopupMenuButton<Choice>(
              onSelected: _select,
              itemBuilder: (BuildContext context) {
                return choices.skip(1).map((Choice choice) {
                  return PopupMenuItem<Choice>(
                    value: choice,
                    child: Text(choice.title),
                  );
                }).toList();
              },
            ),
          ],
        ),
        body: _loadingPage,
        // TODO update drawer genres list according to page selectedPage
        drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text('Drawer Header'),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
              ListTile(
                title: Text('Item 1'),
                onTap: () {
                  // Update the state of the app.
                  // Then close the drawer.
                  _pop();
                },
              ),
              ListTile(
                title: Text('Item 2'),
                onTap: () {
                  // Update the state of the app.
                  // Then close the drawer.
                  _pop();
                },
              ),
            ],
          ),
        ));
  }

  void _pop() {
    Navigator.pop(context);
  }

  void _lastSelectedPage() async {
    final lastSelected = await _prefs.getString(Prefs.K_LAST_SELECTED_PAGE);
    print("lastSelected: $lastSelected");

    setState(() {
      if (lastSelected == "Movies") {
        _loadingPage = MoviesPage();
        _appBarTitle = "Movies";
      } else {
        _loadingPage = TvPage();
        _appBarTitle = "Tv Shows";
      }
    });
  }
}

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'Search', icon: Icons.search),
  const Choice(title: 'Movies', icon: Icons.movie),
  const Choice(title: 'Tv Shows', icon: Icons.tv),
];

class ChoiceCard extends StatelessWidget {
  const ChoiceCard({Key key, this.choice}) : super(key: key);

  final Choice choice;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.display1;
    return Card(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(choice.icon, size: 128.0, color: textStyle.color),
            Text(choice.title, style: textStyle),
          ],
        ),
      ),
    );
  }
}
