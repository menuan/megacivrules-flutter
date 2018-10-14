import 'package:flutter/material.dart';
import 'package:mega_civ_rules/models/data/paragraph.dart';

typedef void OnTapTocRow(int index);

class ParagraphRow extends StatelessWidget {
  ParagraphRow(
      {Key key,
      @required this.context,
      this.paragraph,
      this.parentIndex,
      this.paragraphIndex,
      this.searchString})
      : super(key: key);

  final BuildContext context;
  final Paragraph paragraph;
  final int parentIndex;
  final int paragraphIndex;
  final String searchString;

  List<TextSpan> getMassagedTexts(String content, String searchPattern) {
    List<TextSpan> spans = [];
    final defaultStyle =
        TextStyle(fontWeight: FontWeight.normal, color: Colors.white);
    if (searchPattern != null && searchPattern.length > 2) {
      final contentList = content.split(searchPattern);
      final contentListLength = contentList.length;
      final matches = contentList.length > 1 ? contentList.length - 1 : 0;
      final searchMatchStyle =
          TextStyle(fontWeight: FontWeight.bold, color: Colors.redAccent);
      print("Search pattern is not nil and we have: $contentList, $matches");
      if (matches > 0) {
        print("More than 0 matches!");
//        contentList.forEach((content) {});
        for (var i = 0; i < contentListLength; i++) {
          var content = contentList[i];
          spans.add(TextSpan(style: defaultStyle, text: content));
          if ((contentListLength - 1) != i) {
            spans.add(TextSpan(style: searchMatchStyle, text: searchPattern));
          }
        }
      } else {
        spans.add(TextSpan(style: defaultStyle, text: content));
      }
    } else {
      spans.add(TextSpan(style: defaultStyle, text: content));
    }
    return spans;
  }

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
//    var textWidget = Text(
//      text,
//      textAlign: TextAlign.left,
//      softWrap: true,
//      overflow: TextOverflow.clip,
//      style: TextStyle(fontSize: 15.0),
//    );
    return Container(
      child: RichText(
        text: TextSpan(
            style: DefaultTextStyle.of(context).style,
            children: getMassagedTexts(text, searchString)),
      ),
      padding: EdgeInsets.only(bottom: 20.0, left: 20.0, right: 20.0),
    );
  }

  Widget getImageWidget(String src) {
    return Container(
        width: double.infinity,
        child: Image(image: AssetImage("assets/img/chapters/$src")));
  }

  List<Widget> getPunctuatedListWidget(List<PunctuatedList> punctuated) {
    List<Widget> children = List<Widget>();
    EdgeInsets textPadding = EdgeInsets.only(left: 20.0, top: 10.0);
    punctuated.forEach((p) {
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
    var indexString =
        parentIndex != null ? "$parentIndex:$paragraphIndex " : "";
    return new ExpansionTile(
      title: new Padding(
        padding: new EdgeInsets.only(left: 5.0),
        child: new Text("$indexString${paragraph.title}",
            textAlign: TextAlign.start, style: TextStyle(fontSize: 15.0)),
      ),
      children: children,
    );
  }
}
