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
    List<Widget> children = [];
    for (var item in paragraph.items) {
      // Add text
      var text = new Text(
        item.text,
        textAlign: TextAlign.left,
        softWrap: true,
        overflow: TextOverflow.clip,
        style: TextStyle(fontSize: 20.0),
      );
      var container = Container(child: text);
      children.add(container);

      // Add images
      for (var src in item.images) {
        var image = Container(
            width: double.infinity,
            child: Image(image: AssetImage("assets/img/chapters/$src")));
        children.add(image);
      }
    }

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
