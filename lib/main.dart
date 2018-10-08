import 'dart:async' show Future;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';

// Ours
import 'package:mega_civ_rules/models/chapter.dart';
import 'package:mega_civ_rules/widgets/tableofcontent/tableofcontent.dart';
import 'package:mega_civ_rules/widgets/wikipedia/wikipedia.dart';
import 'package:mega_civ_rules/widgets/progress/progress.dart';
import 'package:mega_civ_rules/services/chapterservice.dart';
import 'package:mega_civ_rules/services/themeservice.dart';

void main() {
  debugPaintSizeEnabled = false;
  runApp(MegaCivRules());
}

class MegaCivRules extends StatefulWidget {
  MegaCivRules({Key key}) : super(key: key);

  @override
  _MegaCivRulesState createState() => new _MegaCivRulesState();
}

class _MegaCivRulesState extends State<MegaCivRules> {
  bool darkThemeEnabled = false;
  int sliderColor = 0;

  MaterialColor themeColor = Colors.lightGreen;

  List<Chapter> chapters = [];
  int selectedIndex = 0;
  SearchBar searchBar;
  String searchString = "";

  void loadSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      darkThemeEnabled = prefs.getBool('theme_dark') ?? false;
      sliderColor = prefs.getInt('theme_color') ?? 0;
      themeColor = ThemeService.getColor(sliderColor);
    });
  }

  @override
  void initState() {
    super.initState();
    loadSharedPreferences();
    searchBar = new SearchBar(
        inBar: false,
        buildDefaultAppBar: buildAppBar,
        setState: setState,
        clearOnSubmit: false,
        onSubmitted: onChangeSearchBar,
        onChanged: onChangeSearchBar,
        onClosed: () {
          setState(() => searchString = "");
        });
    ChapterService.get().then((chapters) {
      this.setState(() {
        this.chapters = chapters;
      });
    });
  }

  ThemeData getThemeData() {
    return ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
//           counter didn't reset back to zero; the application is not restarted.
        brightness: darkThemeEnabled ? Brightness.dark : Brightness.light,
        primarySwatch: themeColor,
        primaryColor: themeColor[700],
        accentColor: themeColor[800],
        backgroundColor: themeColor[100]);
  }

  AppBar buildAppBar(BuildContext context) {
    return new AppBar(
        title: new Text('Mega Civilization Rules'),
        actions: [searchBar.getSearchAction(context)]);
  }

  void onChangeSearchBar(String value) {
    setState(() => searchString = value);
  }

  Widget getNavBar() {
    return Theme(
        data: Theme.of(context).copyWith(
            canvasColor: themeColor,
            primaryColor: themeColor[700],
            textTheme: Theme.of(context)
                .textTheme
                .copyWith(caption: TextStyle(color: themeColor[700]))),
        child: BottomNavigationBar(
            currentIndex: this.selectedIndex,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.book), title: const Text('Rules')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.keyboard), title: const Text('Wikipedia')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.insert_chart),
                  title: const Text('Progress')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.border_all), title: const Text('Cards'))
            ],
            onTap: _onBottomNavigationBarTapped));
  }

  void _onBottomNavigationBarTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void _onSwitchValueChange(bool newValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('Toggling dark theme: $newValue');
    setState(() {
      darkThemeEnabled = newValue;
    });
    prefs.setBool('theme_dark', newValue);
  }

  void _onColorSliderValueChange(double newValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int rounded = newValue.round();
    print('Setting color to index $rounded and saving to storage');
    setState(() {
      sliderColor = rounded;
      themeColor = ThemeService.getColor(sliderColor);
    });
    prefs.setInt('theme_color', rounded);
  }

  Widget getBody() {
    switch (this.selectedIndex) {
      case 0:
        return new TableOfContents(
          chapters: this.chapters,
          searchString: this.searchString,
        );
      case 1:
        return new Wikipedia();
      case 2:
        return new Progress();
      case 3:
        return Text('Cards');
      default:
        return Text('Not implemented');
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget body = getBody();

    return MaterialApp(
        theme: getThemeData(),
        home: Scaffold(
          appBar: searchBar.build(context),
          body: body,
          drawer: Drawer(
              child: ListView(
            children: <Widget>[
              ListTile(
                title: const Text('Dark Theme'),
                trailing: Switch(
                    value: darkThemeEnabled, onChanged: _onSwitchValueChange),
              ),
              ListTile(
                title: const Text('Color'),
                trailing: Slider(
                    min: 0.0,
                    label: "lel",
                    max: ThemeService.presetColors.length + .0,
                    value: sliderColor + .0,
                    onChanged: _onColorSliderValueChange),
              )
            ],
          )),
          bottomNavigationBar:
              getNavBar(), // This trailing comma makes auto-formatting nicer for build methods.
        ));
  }
}
