import 'package:flutter/material.dart';
import 'package:mega_civ_rules/models/paragraph.dart';

typedef void OnTapTocRow(int index);

class ParagraphRow extends StatelessWidget {
  ParagraphRow({this.paragraph, this.parentIndex, this.paragraphIndex});

  final Paragraph paragraph;
  final int parentIndex;
  final int paragraphIndex;

  @override
  Widget build(BuildContext context) {
    var children = paragraph.items.map((p) {
      return new Container(width: double.infinity, child: new Text(p.text));
    }).toList();

    /*var image = Container(child: Image(image: AssetImage("assets/logo.png")));
    children.add(image);
    */

    return new ExpansionTile(
      title: new Padding(
        padding: new EdgeInsets.only(left: 25.0),
        child: new Text("$parentIndex:$paragraphIndex: ${paragraph.title}",
            textAlign: TextAlign.start),
      ),
      children: children,
    );
  }
}
