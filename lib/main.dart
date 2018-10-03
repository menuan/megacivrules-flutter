import 'package:flutter/material.dart';
import 'package:mega_civ_rules/models/chapter.dart';
import 'widgets/tableofcontent.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
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
      home: new MyHomePage(title: 'Mega Civilization Rules'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class WidgetBuilder {
  static Widget getTocRow(int index, String text, OnTapTocRow onTap) {
    return TableOfContentsRow(index: index, text: text, onTap: onTap);
  }
}

class _MyHomePageState extends State<MyHomePage> {
  List<Chapter> chapters = Chapter.chapters();

  @override
  void initState() {
    super.initState();
  }

  BottomNavigationBar getNavBar() {
    return BottomNavigationBar(items: [
      BottomNavigationBarItem(
          icon: Icon(Icons.book), title: const Text('Rules')),
      BottomNavigationBarItem(
          icon: Icon(Icons.keyboard), title: const Text('Wikipedia'))
    ], onTap: _onBottomNavigationBarTapped);
  }

  void _onBottomNavigationBarTapped(int index) {
    print("Index was $index");
  }

  void _onTap(int index) {
    print("on tap $index");
  }

  @override
  Widget build(BuildContext context) {
    int index = 0;
    return new Scaffold(
      appBar: new AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: new Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          TableOfContents(
              chapters: chapters
                  .map((item) =>
                      WidgetBuilder.getTocRow(index++, item.title, _onTap))
                  .toList())
        ],
      ),
      bottomNavigationBar:
          getNavBar(), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
