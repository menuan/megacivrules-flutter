import 'package:flutter/material.dart';
import 'package:mega_civ_rules/models/chapter.dart';
import 'package:mega_civ_rules/widgets/tableofcontent/tableofcontent.dart';
import 'package:mega_civ_rules/widgets/wikipedia/wikipedia.dart';
import 'package:mega_civ_rules/widgets/progress/progress.dart';
import 'package:flutter/rendering.dart';
import 'package:mega_civ_rules/services/chapterservice.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';

void main() {
  debugPaintSizeEnabled = false;
  runApp(new MegaCivRules());
}

class MegaCivRules extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Mega Civilizaton Rules',
      theme: new ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
          // counter didn't reset back to zero; the application is not restarted.
          primarySwatch: Colors.amber,
          backgroundColor: Colors.orangeAccent),
      home: new MegaCivPage(),
    );
  }
}

class MegaCivPage extends StatefulWidget {
  MegaCivPage({Key key}) : super(key: key);

  @override
  _MegaCivPageState createState() => new _MegaCivPageState();
}

class _MegaCivPageState extends State<MegaCivPage> {
  List<Chapter> chapters = [];
  int selectedIndex = 0;
  SearchBar searchBar;
  String searchString = "";

  @override
  void initState() {
    super.initState();
    searchBar = new SearchBar(
        inBar: false,
        buildDefaultAppBar: buildAppBar,
        setState: setState,
        clearOnSubmit: false,
        onSubmitted: onSubmitted,
        onChanged: onChange,
        onClosed: () {
          setState(() => searchString = "");
        });
    ChapterService.get().then((chapters) {
      this.setState(() {
        this.chapters = chapters;
      });
    });
  }

  AppBar buildAppBar(BuildContext context) {
    return new AppBar(
        title: new Text('Mega Civilization Rules'),
        actions: [searchBar.getSearchAction(context)]);
  }

  void onChange(String value) {
    setState(() => searchString = value);
  }

  void onSubmitted(String value) {
    setState(() => searchString = value);
  }

  BottomNavigationBar getNavBar() {
    return BottomNavigationBar(
        currentIndex: this.selectedIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.book), title: const Text('Rules')),
          BottomNavigationBarItem(
              icon: Icon(Icons.keyboard), title: const Text('Wikipedia')),
          BottomNavigationBarItem(
              icon: Icon(Icons.insert_chart), title: const Text('Progress'))
        ],
        onTap: _onBottomNavigationBarTapped);
  }

  void _onBottomNavigationBarTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
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
      default:
        return Text("Not implemented");
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget body = getBody();

    return new Scaffold(
      appBar: searchBar.build(context),
      body: body,
      bottomNavigationBar:
          getNavBar(), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
