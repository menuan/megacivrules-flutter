// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'civilizationadvance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CivilizationAdvance _$CivilizationAdvanceFromJson(Map<String, dynamic> json) {
  return new CivilizationAdvance(
      groups: (json['groups'] as List)
          ?.map((e) => $enumDecodeNullable('CivilizationAdvanceGroup',
              CivilizationAdvanceGroup.values, e as String))
          ?.toList(),
      victoryPoints: json['victoryPoints'] as int,
      cost: json['cost'] as int,
      attributes:
          (json['attributes'] as List)?.map((e) => e as String)?.toList(),
      name: json['name'] as String);
}

abstract class _$CivilizationAdvanceSerializerMixin {
  List<CivilizationAdvanceGroup> get groups;
  int get victoryPoints;
  int get cost;
  List<String> get attributes;
  String get name;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'groups': groups?.map((e) => e?.toString()?.split('.')?.last)?.toList(),
        'victoryPoints': victoryPoints,
        'cost': cost,
        'attributes': attributes,
        'name': name
      };
}
