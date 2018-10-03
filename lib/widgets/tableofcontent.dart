import 'package:flutter/material.dart';

typedef void OnTapTocRow(int index);

class TableOfContentsRow extends StatelessWidget {
  TableOfContentsRow({this.index, this.text, this.onTap});

  final int index;
  final String text;
  final OnTapTocRow onTap;

  _onTap() {
    onTap(index);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(mainAxisSize: MainAxisSize.max, children: [
      Flexible(
          child: GestureDetector(
        child: Text(
          "$index. $text",
          overflow: TextOverflow.clip,
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
        ),
        onTap: _onTap,
      ))
    ]);
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
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: chapters,
          )
        ], overflow: Overflow.clip));
  }
}
