import 'package:flutter/material.dart';
import 'package:mega_civ_rules/models/data/chapter.dart';
import 'package:mega_civ_rules/widgets/rulebook/chapterrow.dart';

class Rulebook extends StatelessWidget {
  Rulebook({Key key, @required this.chapters, this.searchString})
      : super(key: key);

  final List<Chapter> chapters;
  final String searchString;

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

//class RulebookState extends State<Rulebook> {
//  final List<Chapter> chapters;
//  String searchString;
//
//
//}
