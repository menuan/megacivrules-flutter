import 'package:flutter/material.dart';

class TableOfContentsRow extends StatelessWidget {
  TableOfContentsRow({this.index, this.text});

  final int index;
  final String text;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      children: [
        GestureDetector(
          child: Text(
            "$index. $text",
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
          ),
          onTap: () {
            print("on tap $text");
          },
        )
      ],
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
        padding: EdgeInsets.all(40.0),
        child: Stack(children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: chapters,
          )
        ]));
  }
}
