import 'package:flutter/material.dart';
import 'package:mega_civ_rules/models/paragraph.dart';

typedef void OnTapTocRow(int index);

class ParagraphRow extends StatelessWidget {
  ParagraphRow(
      {this.paragraph,
      this.parentIndex,
      this.paragraphIndex,
      this.searchString});

  final Paragraph paragraph;
  final int parentIndex;
  final int paragraphIndex;
  String searchString;

  Widget getTextWidget(String text) {
    var textWidget = new Text(
      text,
      textAlign: TextAlign.left,
      softWrap: true,
      overflow: TextOverflow.clip,
      style: TextStyle(fontSize: 20.0),
    );
    var container = Container(
      child: textWidget,
      padding: EdgeInsets.all(20.0),
    );
    return container;
  }

  Widget getImageWidget(String src) {
    return Container(
        width: double.infinity,
        child: Image(image: AssetImage("assets/img/chapters/$src")));
  }

  List<Widget> getPunctuatedListWidget(List<PunctuatedList> puncuated) {
    List<Widget> children = List<Widget>();
    EdgeInsets textPadding = EdgeInsets.only(left: 20.0, top: 10.0);
    puncuated.forEach((p) {
      List<Widget> c = List<Widget>();
      // Add title
      c.add(Row(children: [
        Container(
            padding: textPadding,
            child: Text(
              p.title,
              textAlign: TextAlign.left,
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
      ]));

      // Add text
      if (p.text != null && p.text.length > 0) {
        c.add(Row(children: [
          Container(
              padding: textPadding,
              child: Text(p.text, textAlign: TextAlign.left))
        ]));
      }

      // Add punctuated list
      p.items.forEach((val) {
        c.add(ListTile(
          leading:
              val.leading != null ? Text(val.leading) : Icon(Icons.arrow_right),
          title: val.title != null ? Text(val.title) : null,
          subtitle: val.text != null ? Text(val.text) : null,
        ));
      });
      children.add(Column(
        children: c,
      ));
    });
    return children;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    for (var item in paragraph.items) {
      // Add text
      if (item.text != null && item.text.length > 0) {
        var textWidget = getTextWidget(item.text);
        children.add(textWidget);
      }

      // Add images
      if (item.images != null) {
        for (var src in item.images) {
          var image = getImageWidget(src);
          children.add(image);
        }
      }

      // Add list
      if (item.punctuatedTextList != null) {
        var punctuated = getPunctuatedListWidget(item.punctuatedTextList);
        children.addAll(punctuated);
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
