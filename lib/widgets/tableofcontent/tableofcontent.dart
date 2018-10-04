import 'package:flutter/material.dart';
import 'package:mega_civ_rules/models/chapter.dart';
import 'package:mega_civ_rules/widgets/tableofcontent/chapterrow.dart';

class TableOfContents extends StatelessWidget {
  TableOfContents({this.chapters});

  final List<Chapter> chapters;

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemBuilder: (context, i) =>
          new ChapterRow(chapter: chapters[i], index: i + 1),
      itemCount: chapters.length,
    );
  }
}
