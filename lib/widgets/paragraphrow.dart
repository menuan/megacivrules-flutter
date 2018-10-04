import 'package:flutter/material.dart';
import 'package:mega_civ_rules/models/paragraph.dart';

typedef void OnTapTocRow(int index);

class ParagraphRow extends StatelessWidget {
  ParagraphRow({this.paragraph});

  final Paragraph paragraph;

  @override
  Widget build(BuildContext context) {
    return new ExpansionTile(
      title: new Text(paragraph.title, textAlign: TextAlign.start),
      children: paragraph.text.map((p) {
        return new Text(p);
      }).toList(),
    );
  }
}
