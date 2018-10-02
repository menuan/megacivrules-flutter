import 'package:flutter/material.dart';

class TableOfContentsRow extends StatelessWidget {
  TableOfContentsRow({this.index, this.text});

  final int index;
  final String text;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Text(
      "$index. $text",
      textAlign: TextAlign.left,
      style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
    );
  }
}

class TableOfContents extends StatelessWidget {
  TableOfContents({this.chapters});

  final List<Widget> chapters;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        child: Stack(children: <Widget>[
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: chapters,
      )
    ]));
  }
}
