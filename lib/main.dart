import 'dart:async' show Timer;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

// Ours
import 'package:mega_civ_rules/models/data/chapter.dart';
import 'package:mega_civ_rules/widgets/rulebook/rulebook.dart';
import 'package:mega_civ_rules/widgets/progress/progress.dart';
import 'package:mega_civ_rules/services/chapterservice.dart';
import 'package:mega_civ_rules/services/wikipediaService.dart';
import 'package:mega_civ_rules/services/themeservice.dart';
import 'package:flutter/services.dart';
import 'package:mega_civ_rules/widgets/searchbar/search_controller.dart';

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
  static const splashTimeout = const Duration(milliseconds: 2000);
  static const searchDebounceTimeout = const Duration(milliseconds: 750);

//  final PublishSubject<String> searchStringSubject = PublishSubject<String>();
  Timer splashTimer;
  bool darkThemeEnabled = false;
  int sliderColor = 0;

  MaterialColor themeColor = Colors.lightGreen;

  List<Chapter> chapters = [];
  List<Chapter> wikipediaChapters = [];

  int _pageIndex = 0;
  PageController _pageController;

  SearchController searchController;
  TextEditingController controller = TextEditingController();
  String searchString;
  bool isSearching = false;
  PublishSubject<String> subject = PublishSubject<String>();

  void loadSharedPreferences() async {
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        darkThemeEnabled = prefs.getBool('theme_dark') ?? false;
        sliderColor = prefs.getInt('theme_color') ?? 0;
        themeColor = ThemeService.getColor(sliderColor);
      });
    });
  }

  @override
  void initState() {
    _pageController = new PageController(
      initialPage: _pageIndex,
    );
    super.initState();
    loadSharedPreferences();
    ChapterService.get().then((chapters) {
      this.setState(() {
        this.chapters = chapters;
      });
    });
    WikipediaService.get().then((chapters) {
      this.setState(() {
        this.wikipediaChapters = chapters;
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
        accentColor: themeColor[900],
        backgroundColor: themeColor[100]);
  }

  AppBar buildAppBar(BuildContext context) {
    return new AppBar(
        title: new Text('Mega Civilization Rules'),
        centerTitle: false,
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                setState(() {
                  isSearching = true;
                });
              }),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              print("Settings - On pressed");
            },
            tooltip: "Go to the settings view!",
          )
        ]);
  }

  Widget getNavBar() {
    return Theme(
        data: Theme.of(context).copyWith(
            canvasColor: themeColor[700],
            primaryColor: themeColor[900],
            textTheme: Theme.of(context)
                .textTheme
                .copyWith(caption: TextStyle(color: Colors.white))),
        child: BottomNavigationBar(
            currentIndex: _pageIndex,
            onTap: (index) {
              this._pageController.animateToPage(index,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut);
            },
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.book), title: const Text('Rules')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.keyboard), title: const Text('Wikipedia')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.insert_chart), title: const Text('Progress'))
            ]));
  }

  void _onSwitchValueChange(bool newValue) async {
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        darkThemeEnabled = newValue;
      });
      prefs.setBool('theme_dark', newValue);
    });
  }

  void _onColorSliderValueChange(double newValue) async {
    SharedPreferences.getInstance().then((prefs) {
      int rounded = newValue.round();
      setState(() {
        sliderColor = rounded;
        themeColor = ThemeService.getColor(sliderColor);
      });
      prefs.setInt('theme_color', rounded);
    });
  }

  Widget getHome(BuildContext context) {
    searchController = SearchController(
      appBarBuilder: buildAppBar,
      subject: subject,
      controller: controller,
      isSearching: isSearching,
      onClosed: () {
        setState(() {
          isSearching = false;
          searchString = null;
        });
      },
      closeOnSubmit: true,
    );

    subject.stream.debounce(searchDebounceTimeout).listen((String event) {
      print("New search event $event");
      setState(() {
        searchString = event;
      });
    });

    return Scaffold(
      appBar: searchController.build(context),
      body: PageView(
        controller: _pageController,
        onPageChanged: (newPage) {
          setState(() {
            this._pageIndex = newPage;
          });
        },
        children: getBody(),
      ),
      drawer: getDrawer(),
      bottomNavigationBar:
          getNavBar(), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget getDrawer() {
    return Drawer(
        child: ListView(
      children: <Widget>[
        ListTile(
          title: const Text('Dark Theme'),
          trailing:
              Switch(value: darkThemeEnabled, onChanged: _onSwitchValueChange),
        ),
        ListTile(
          title: const Text('Color'),
          trailing: Slider(
              min: 0.0,
              label: "lel",
              max: ThemeService.presetColors.length + .0,
              value: sliderColor + .0,
              onChanged: _onColorSliderValueChange),
        ),
      ],
    ));
  }

  List<Widget> getBody() {
    return [
      Rulebook(
          includeIndex: true, chapters: chapters, searchString: searchString),
      Rulebook(
          includeIndex: false,
          chapters: wikipediaChapters,
          searchString: searchString),
      Progress(
        // key: progressKey,
        searchString: searchString,
      )
    ];
  }

  void handleSplashTimeout(BuildContext context) {
    setState(() {
      Navigator.popAndPushNamed(context, '/app');
    });
  }

  Widget getSplashImage() {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fitWidth,
              image: AssetImage('assets/img/splash.png'))),
    );
  }

  Scaffold getSplashScreen(BuildContext context) {
    splashTimer = Timer(splashTimeout, () => handleSplashTimeout(context));

    return Scaffold(
        body: Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Container(decoration: BoxDecoration(color: themeColor)),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[Expanded(child: getSplashImage())],
        )
      ],
    ));
  }

  Widget getSettings(BuildContext context) {
    return Scaffold(
        body: Stack(
      fit: StackFit.expand,
      children: <Widget>[],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: getThemeData(),
      initialRoute: '/',
      routes: {
        '/': (context) => getSplashScreen(context),
        '/app': (context) => getHome(context),
        '/settings': (context) => getSettings(context)
      },
    );
  }
}
