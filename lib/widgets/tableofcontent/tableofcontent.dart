import 'package:flutter/material.dart';
import 'package:mega_civ_rules/models/chapter.dart';
import 'package:mega_civ_rules/widgets/tableofcontent/chapterrow.dart';

class TableOfContents extends StatelessWidget {
  TableOfContents({this.chapters, this.searchString});

  final List<Chapter> chapters;
  String searchString;

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemBuilder: (context, i) => new ChapterRow(
            chapter: chapters[i],
            index: i + 1,
            searchString: this.searchString,
          ),
      itemCount: chapters.length,
    );
  }
}
