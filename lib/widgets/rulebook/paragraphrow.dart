import 'package:flutter/material.dart';
import 'package:mega_civ_rules/models/data/paragraph.dart';

// Ours
import 'package:mega_civ_rules/services/utils.dart';

typedef void OnTapTocRow(int index);

class ParagraphRowViewModel {
  ParagraphRowViewModel(
      {Key key,
      @required this.paragraph,
      @required this.parentIndex,
      @required this.paragraphIndex,
      @required this.searchString}) {
    itemMatches = searchString != null
        ? paragraph.items.map((ParagraphItem item) {
            final textContentList =
                item.text != null ? item.text.split(searchString) : ["kek"];
            final matches = textContentList.length - 1;
            return matches > 0;
          }).toList()
        : List<bool>(paragraph.items.length);
  }

  int matches = 0;
  List<bool> itemMatches;
  final Paragraph paragraph;
  final int parentIndex;
  final int paragraphIndex;
  final String searchString;

  bool hasMatches() {
    return searchString == null ? true : itemMatches.any((element) => element);
  }

  bool doesItemHasMatches(int index) {
    return searchString == null ? true : itemMatches[index];
  }
}

class ParagraphRow extends StatelessWidget {
  ParagraphRow({Key key, @required this.context, @required this.viewModel})
      : super(key: key);

  final BuildContext context;
  final ParagraphRowViewModel viewModel;

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
    return Container(
      child: RichText(
        text: TextSpan(
            style: DefaultTextStyle.of(context).style,
            children: Utils.getMassagedTexts(text, viewModel.searchString)),
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
    for (var item in viewModel.paragraph.items) {
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
    var indexString = viewModel.parentIndex != null
        ? "${viewModel.parentIndex}:${viewModel.paragraphIndex} "
        : "";
    var hasMatches = viewModel.hasMatches();
    return new ExpansionTile(
      key: Key("$indexString$hasMatches"),
      initiallyExpanded: hasMatches,
      title: new Padding(
        padding: new EdgeInsets.only(left: 5.0),
        child: new Text("$indexString${viewModel.paragraph.title}",
            textAlign: TextAlign.start, style: TextStyle(fontSize: 15.0)),
      ),
      children: children,
    );
  }
}
