import 'package:flutter/material.dart';

import 'package:rxdart/rxdart.dart';

typedef Widget AppBarCallback(BuildContext context);

class SearchController extends StatelessWidget {
  SearchController(
      {Key key,
      @required this.appBarBuilder,
      @required this.subject,
      @required this.controller,
      @required this.isSearching,
      this.onClosed,
      this.closeOnSubmit = false})
      : super(key: key);

  final AppBarCallback appBarBuilder;
  final bool isSearching;
  final VoidCallback onClosed;
  final bool closeOnSubmit;
  final PublishSubject<String> subject;
  final TextEditingController controller;

  @override
  AppBar build(BuildContext context) {
    return isSearching ? searchAppBarBuilder(context) : appBarBuilder(context);
  }

  AppBar searchAppBarBuilder(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    Directionality title = Directionality(
        textDirection: Directionality.of(context),
        child: TextField(
          key: Key('SearchBarTextField'),
          keyboardType: TextInputType.text,
          style: TextStyle(color: themeData.textSelectionColor, fontSize: 16.0),
          decoration: InputDecoration(
              hintText: 'Keckler',
              hintStyle: TextStyle(color: themeData.hintColor, fontSize: 16.0),
              border: null),
          onChanged: (String value) {
            subject.add(value);
          },
          onSubmitted: (String value) {
            subject.add(value);
            if (closeOnSubmit) {
              clear();
            }
          },
          autofocus: true,
          controller: controller,
        ));
    return AppBar(
      leading: IconButton(
        icon: const BackButtonIcon(),
        tooltip: MaterialLocalizations.of(context).backButtonTooltip,
        onPressed: () {
          if (onClosed != null) {
            onClosed();
          }
          clear();
        },
      ),
      backgroundColor: themeData.backgroundColor,
      title: title,
    );
  }

  void clear() {
    print("Clearing and resetting");
    controller.clear();
    if (onClosed != null) {
      onClosed();
    }
  }
}
