import 'package:flutter/material.dart';
import 'package:mega_civ_rules/models/data/chapter.dart';
import 'package:mega_civ_rules/widgets/tableofcontent/chapterrow.dart';

class TableOfContents extends StatelessWidget {
  TableOfContents({this.chapters, this.searchString, this.includeIndex});

  final List<Chapter> chapters;
  String searchString;
  final bool includeIndex;

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemBuilder: (context, i) => new ChapterRow(
            chapter: chapters[i],
            index: includeIndex ? i + 1 : null,
            searchString: this.searchString,
          ),
      itemCount: chapters.length,
    );
  }
}
