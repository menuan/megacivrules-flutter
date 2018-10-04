import 'package:flutter/material.dart';
import 'package:mega_civ_rules/models/chapter.dart';
import 'package:mega_civ_rules/widgets/paragraphrow.dart';

typedef void OnTapTocRow(int index);

class ChapterRow extends StatelessWidget {
  ChapterRow({this.chapter, this.index});

  final Chapter chapter;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: new Text("$index: ${chapter.title}",
          style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
          textAlign: TextAlign.start),
      children: chapter.paragraphs
          .map((val) => ParagraphRow(
                paragraph: val,
              ))
          .toList(),
    );
  }
}
