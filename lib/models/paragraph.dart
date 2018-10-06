import 'package:json_annotation/json_annotation.dart';
part 'paragraph.g.dart';

@JsonSerializable()
class Paragraph extends Object with _$ParagraphSerializerMixin {
  String title;
  List<ParagraphItem> items;
  Paragraph(this.title, this.items);

  factory Paragraph.fromJson(Map<String, dynamic> json) =>
      _$ParagraphFromJson(json);
}

@JsonSerializable()
class ParagraphItem extends Object with _$ParagraphItemSerializerMixin {
  String text;
  List<PunctuatedList> punctuatedTextList;
  List<String> images;
  ParagraphItem(this.text, this.images, this.punctuatedTextList);

  factory ParagraphItem.fromJson(Map<String, dynamic> json) =>
      _$ParagraphItemFromJson(json);
}

@JsonSerializable()
class PunctuatedList extends Object with _$PunctuatedListSerializerMixin {
  String title;
  String text;
  List<PunctuatedListItem> items;
  PunctuatedList({this.title, this.text, this.items});

  factory PunctuatedList.fromJson(Map<String, dynamic> json) =>
      _$PunctuatedListFromJson(json);
}

@JsonSerializable()
class PunctuatedListItem extends Object
    with _$PunctuatedListItemSerializerMixin {
  String text;
  String title;
  String leading;

  PunctuatedListItem({this.text, this.title, this.leading});

  factory PunctuatedListItem.fromJson(Map<String, dynamic> json) =>
      _$PunctuatedListItemFromJson(json);
}
