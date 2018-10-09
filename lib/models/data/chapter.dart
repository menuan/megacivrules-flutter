import 'package:mega_civ_rules/models/data/paragraph.dart';
import 'package:json_annotation/json_annotation.dart';
part 'package:mega_civ_rules/models/data/chapter.g.dart';

@JsonSerializable()
class Chapter extends Object with _$ChapterSerializerMixin {
  String title;
  List<Paragraph> paragraphs;

  Chapter(this.title, this.paragraphs);

  factory Chapter.fromJson(Map<String, dynamic> json) =>
      _$ChapterFromJson(json);
}
