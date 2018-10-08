import 'package:flutter/material.dart';
import 'package:mega_civ_rules/models/chapter.dart';
import 'package:mega_civ_rules/widgets/tableofcontent/paragraphrow.dart';

typedef void OnTapTocRow(int index);

class ChapterRow extends StatelessWidget {
  ChapterRow({this.chapter, this.index, this.searchString});

  final Chapter chapter;
  final int index;
  String searchString;

  @override
  Widget build(BuildContext context) {
    var paragraphIndex = 1;

    return ExpansionTile(
      title: new Text("$index: ${chapter.title}",
          style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
          textAlign: TextAlign.start),
      children: chapter.paragraphs
          .map((val) => ParagraphRow(
                paragraph: val,
                parentIndex: index,
                paragraphIndex: paragraphIndex++,
                searchString: this.searchString,
              ))
          .toList(),
    );
  }
}
