// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paragraph.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Paragraph _$ParagraphFromJson(Map<String, dynamic> json) {
  return new Paragraph(
      json['title'] as String,
      (json['items'] as List)
          ?.map((e) => e == null
              ? null
              : new ParagraphItem.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

abstract class _$ParagraphSerializerMixin {
  String get title;
  List<ParagraphItem> get items;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'title': title, 'items': items};
}

ParagraphItem _$ParagraphItemFromJson(Map<String, dynamic> json) {
  return new ParagraphItem(
      json['text'] as String,
      (json['images'] as List)?.map((e) => e as String)?.toList(),
      (json['punctuatedTextList'] as List)
          ?.map((e) => e == null
              ? null
              : new PunctuatedList.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

abstract class _$ParagraphItemSerializerMixin {
  String get text;
  List<PunctuatedList> get punctuatedTextList;
  List<String> get images;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'text': text,
        'punctuatedTextList': punctuatedTextList,
        'images': images
      };
}

PunctuatedList _$PunctuatedListFromJson(Map<String, dynamic> json) {
  return new PunctuatedList(
      title: json['title'] as String,
      text: json['text'] as String,
      items: (json['items'] as List)
          ?.map((e) => e == null
              ? null
              : new PunctuatedListItem.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

abstract class _$PunctuatedListSerializerMixin {
  String get title;
  String get text;
  List<PunctuatedListItem> get items;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'title': title, 'text': text, 'items': items};
}

PunctuatedListItem _$PunctuatedListItemFromJson(Map<String, dynamic> json) {
  return new PunctuatedListItem(
      text: json['text'] as String,
      title: json['title'] as String,
      leading: json['leading'] as String);
}

abstract class _$PunctuatedListItemSerializerMixin {
  String get text;
  String get title;
  String get leading;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'text': text, 'title': title, 'leading': leading};
}
