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
    var anyHasMatches = false;
    List<ParagraphRow> paragraphs = chapter.paragraphs
        .map((val) => ParagraphRow(
              context: context,
              viewModel: ParagraphRowViewModel(
                  paragraph: val,
                  parentIndex: index,
                  paragraphIndex: paragraphIndex++,
                  searchString: this.searchString),
            ))
        .where((ParagraphRow row) {
      anyHasMatches |= row.viewModel.hasMatches();
      return row.viewModel.hasMatches();
    }).toList();
    var shouldExpand = searchString == null ? false : anyHasMatches;

    return ExpansionTile(
      key: Key("$indexString$shouldExpand"),
      initiallyExpanded: shouldExpand,
      title: Text("$indexString${chapter.title}",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
          textAlign: TextAlign.start),
      children: paragraphs,
    );
  }
}
