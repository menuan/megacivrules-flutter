import 'package:mega_civ_rules/models/paragraph.dart';

class Chapter {
  String title;
  List<Paragraph> paragraphs;

  Chapter(this.title, this.paragraphs);

  Chapter.fromJSON(Map<String, dynamic> json) : title = json['title'] {
    this.paragraphs = List.from((json["paragraphs"] as List)).map((itemJson) {
      return Paragraph.fromJSON(itemJson);
    }).toList();
  }
}
