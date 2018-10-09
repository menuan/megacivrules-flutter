// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chapter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Chapter _$ChapterFromJson(Map<String, dynamic> json) {
  return new Chapter(
      json['title'] as String,
      (json['paragraphs'] as List)
          ?.map((e) => e == null
              ? null
              : new Paragraph.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

abstract class _$ChapterSerializerMixin {
  String get title;
  List<Paragraph> get paragraphs;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'title': title, 'paragraphs': paragraphs};
}
