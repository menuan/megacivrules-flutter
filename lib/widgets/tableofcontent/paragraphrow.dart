import 'package:flutter/material.dart';
import 'package:mega_civ_rules/models/data/paragraph.dart';

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

  Widget getTitleWidget(String text) {
    var textWidget = Container(
        padding: EdgeInsets.only(left: 20.0),
        child: Text(
          text,
          textAlign: TextAlign.left,
          softWrap: true,
          overflow: TextOverflow.clip,
          style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
        ));
    var container = Row(children: [textWidget]);
    return container;
  }

  Widget getTextWidget(String text) {
    var textWidget = new Text(
      text,
      textAlign: TextAlign.left,
      softWrap: true,
      overflow: TextOverflow.clip,
      style: TextStyle(fontSize: 15.0),
    );
    var container = Container(
      child: textWidget,
      padding: EdgeInsets.only(bottom: 20.0, left: 20.0, right: 20.0),
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
      c.add(Column(children: [
        Container(
            padding: textPadding,
            child: Text(
              p.title,
              overflow: TextOverflow.clip,
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
            )),
      ]));

      // Add text
      if (p.text != null && p.text.length > 0) {
        c.add(Column(children: [
          Container(
              padding: textPadding,
              child: Text(
                p.text,
                overflow: TextOverflow.clip,
                textAlign: TextAlign.left,
                style: TextStyle(fontStyle: FontStyle.italic),
              ))
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
      // Add title/text
      if (item.title != null && item.title.length > 0) {
        var textWidget = getTitleWidget(item.title);
        children.add(textWidget);
      }
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
        padding: new EdgeInsets.only(left: 5.0),
        child: new Text("$parentIndex:$paragraphIndex ${paragraph.title}",
            textAlign: TextAlign.start, style: TextStyle(fontSize: 15.0)),
      ),
      children: children,
    );
  }
}
