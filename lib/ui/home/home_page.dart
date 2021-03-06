import 'package:fimber/fimber.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tmdbflutter/bloc/genres_bloc.dart';
import 'package:tmdbflutter/bloc/theme_bloc.dart';
import 'package:tmdbflutter/bloc_provider.dart' as BP;
import 'package:tmdbflutter/models/genre.dart';
import 'package:tmdbflutter/ui/details/details_page.dart';
import 'package:tmdbflutter/ui/movies/movies_page.dart';
import 'package:tmdbflutter/ui/tv/tv_page.dart';
import 'package:tmdbflutter/utils/app_navigator.dart';
import 'package:tmdbflutter/utils/prefs.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  final Prefs _prefs = Prefs();

  GenresBloc _genresBloc;
  ThemeBloc _themeBloc;

  Widget _loadingPage = MoviesPage();
  String _appBarTitle = "Movies";
  bool _isDarkTheme = false;
  String _currentTheme = "Light";

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _themeBloc = BP.BlocProvider.of<ThemeBloc>(context);
    Fimber.d("_themeBloc: $_themeBloc");

    _lastSelectedPage();
    _genresBloc = GenresBloc(
        genreType:
            (_loadingPage is MoviesPage) ? GenreType.movie : GenreType.tv);

    _lastSelectedTheme();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ThemeState>(
      stream: _themeBloc.themeStateStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        Fimber.d("_themeBloc.themeTypeStream: ${snapshot.data}");
        return Scaffold(
            appBar: AppBar(
              title: Text(_appBarTitle),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () => AppNavigator.goToSearch(
                      context,
                      (_loadingPage is MoviesPage)
                          ? DetailsType.movie
                          : DetailsType.tv),
                ),
                PopupMenuButton<Choice>(
                  onSelected: _select,
                  itemBuilder: (BuildContext context) {
                    return choices.map((Choice choice) {
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
            drawer: _buildDrawer());
      },
    );
  }

  Drawer _buildDrawer() {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: Container(
        child: StreamBuilder<List<Genre>>(
            initialData: [],
            stream: _genresBloc.genresStream,
            builder: (context, snapshot) {
              return ListView(
                // Important: Remove any padding from the ListView.
                padding: EdgeInsets.zero,
                children: _buildDrawerListTiles(snapshot.data),
              );
            }),
      ),
    );
  }

  _buildDrawerListTiles(List<Genre> genres) {
    Fimber.d("_buildDrawerListTiles");
    List<Widget> list = List()
      ..add(_drawerHeader())
      ..add(_themeListTile())
      ..add(_genresListTile());

    genres.forEach((g) {
      list.add(ListTile(
        title: Text(g.name),
        onTap: () {
          // TODO: create filters for specific genres type.
          // Update the state of the app.
          // Then close the drawer.
          _pop();
        },
      ));
    });
    return list;
  }

  ListTile _genresListTile() {
    return ListTile(
      title: Text(
        'Genres',
        style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
      ),
    );
  }

  ListTile _themeListTile() {
    return ListTile(
      title: Text('Theme'),
      subtitle: Text(_currentTheme),
      trailing: Switch(
        value: _isDarkTheme,
        onChanged: (value) => _onThemeChanged(value),
      ),
      onTap: () => _onThemeChanged(!_isDarkTheme),
    );
  }

  DrawerHeader _drawerHeader() {
    return DrawerHeader(
      child: Column(
        children: <Widget>[
          Icon(
            Icons.movie_filter,
            size: 100,
            color: Colors.lightGreen,
          ),
          Text(
            'The Movie DB',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  void _pop() {
    AppNavigator.pop(context);
  }

  void _select(Choice choice) async {
    await _prefs.saveString(Prefs.K_LAST_SELECTED_PAGE, choice.title);
    _lastSelectedPage();
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
    _genresBloc.changeGenres(
        (_loadingPage is MoviesPage) ? GenreType.movie : GenreType.tv);
  }

  void _onThemeChanged(bool value) async {
    Fimber.d("_onThemeChanged: $value");
    await _themeBloc.changeTheme(value);
    _lastSelectedTheme();
  }

  void _lastSelectedTheme() async {
    final lastTheme = await _prefs.getBool(Prefs.K_LAST_THEME_TYPE) ?? false;
//    Fimber.d("lastTheme: $lastTheme");
    setState(() {
      _isDarkTheme = lastTheme ?? false;
      _currentTheme = lastTheme ? "Dark" : "Light";
    });
  }
}

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'Movies', icon: Icons.movie),
  const Choice(title: 'Tv Shows', icon: Icons.tv),
];
