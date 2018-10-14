import 'package:flutter/material.dart';
import 'package:mega_civ_rules/models/data/chapter.dart';
import 'package:mega_civ_rules/widgets/rulebook/paragraphrow.dart';

typedef void OnTapTocRow(int index);

class ChapterRow extends StatelessWidget {
  ChapterRow({Key key, this.chapter, this.index, this.searchString})
      : super(key: key);

  final Chapter chapter;
  final int index;
  final String searchString;

  @override
  Widget build(BuildContext context) {
    var paragraphIndex = 1;
    String indexString = index != null ? "$index: " : "";
    return ExpansionTile(
      title: Text("$indexString${chapter.title}",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
          textAlign: TextAlign.start),
      children: chapter.paragraphs
          .map((val) => ParagraphRow(
                context: context,
                paragraph: val,
                parentIndex: index,
                paragraphIndex: paragraphIndex++,
                searchString: this.searchString,
              ))
          .toList(),
    );
  }
}
