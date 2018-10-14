import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  SearchBar(
      {Key key,
      @required this.theme,
      @required this.controller,
      @required this.hintText,
      this.searchString})
      : super(key: key);

  final Theme theme;
  final TextEditingController controller;
  final String hintText;
  final String searchString;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: Directionality.of(context),
      child: new TextField(
          autofocus: true,
          controller: controller,
          key: new Key('SearchBarTextField'),
          keyboardType: TextInputType.text,
          style: new TextStyle(color: theme.data.primaryColor, fontSize: 16.0),
          decoration: new InputDecoration(
              hintText: hintText,
              hintStyle:
                  new TextStyle(color: theme.data.hintColor, fontSize: 16.0),
              border: null),
          onChanged: onChanged,
          onSubmitted: (String value) => print("On submitted - $value")),
    );
  }

  void onChanged(String value) {
    print("Value changed to $value");
  }
}
