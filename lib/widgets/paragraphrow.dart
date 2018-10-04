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
    /*paragraph.items.map((p) {
      return new Container(width: double.infinity, child: new Text(p.text));
    }).toList();*/
    for (var item in paragraph.items) {
      print("items");
      print(item);
      children.add(
          new Container(width: double.infinity, child: new Text(item.text)));
      for (var src in item.images) {
        print("image");
        print(src);
        var image =
            Container(child: Image(image: AssetImage("assets/chapters/$src")));
        children.add(image);
      }
    }
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
