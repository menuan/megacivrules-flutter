import 'package:flutter/material.dart';
import 'package:mega_civ_rules/models/data/chapter.dart';
import 'package:mega_civ_rules/widgets/rulebook/chapterrow.dart';

class Rulebook extends StatelessWidget {
  Rulebook(
      {Key key, @required this.chapters, this.searchString, this.includeIndex})
      : super(key: key);

  final List<Chapter> chapters;
  final String searchString;
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

//class RulebookState extends State<Rulebook> {
//  final List<Chapter> chapters;
//  String searchString;
//
//
//}
