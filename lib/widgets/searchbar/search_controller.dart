import 'package:flutter/material.dart';

import 'package:rxdart/rxdart.dart';

import 'package:mega_civ_rules/widgets/searchbar/search_bar.dart';

typedef Widget AppBarCallback(BuildContext context);

class SearchController extends StatelessWidget {
  SearchController({Key key}) : super(key: key) {
    subject = PublishSubject<String>();
  }

  final AppBarCallback appBarBuilder;
  final ValueNotifier<bool> isSearching = ValueNotifier(false);
  PublishSubject<String> subject;

  @override
  Widget build(BuildContext context) {
    return isSearching.value ?
  }

  IconButton getSearchButton() {
    return IconButton(
        icon: Icon(Icons.search),
        onPressed: () {
          beginSearch();
        });
  }

  void beginSearch({Theme theme}) {
    print("And so the search began..!");
//    appbar.title = SearchBar(theme: theme, controller: null, hintText: null);
  }
}
