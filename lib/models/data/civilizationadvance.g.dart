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
      name: json['name'] as String,
      id: json['id'] as String)
    ..reduceCosts = (json['reduceCosts'] as List)
        ?.map((e) => e == null
            ? null
            : new CivilizationAdvanceReducedCost.fromJson(
                e as Map<String, dynamic>))
        ?.toList()
    ..colorCredits = (json['colorCredits'] as List)
        ?.map((e) => e == null
            ? null
            : new ColorCredit.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

abstract class _$CivilizationAdvanceSerializerMixin {
  List<CivilizationAdvanceGroup> get groups;
  int get victoryPoints;
  int get cost;
  List<String> get attributes;
  String get name;
  List<CivilizationAdvanceReducedCost> get reduceCosts;
  String get id;
  List<ColorCredit> get colorCredits;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'groups': groups?.map((e) => e?.toString()?.split('.')?.last)?.toList(),
        'victoryPoints': victoryPoints,
        'cost': cost,
        'attributes': attributes,
        'name': name,
        'reduceCosts': reduceCosts,
        'id': id,
        'colorCredits': colorCredits
      };
}

CivilizationAdvanceReducedCost _$CivilizationAdvanceReducedCostFromJson(
    Map<String, dynamic> json) {
  return new CivilizationAdvanceReducedCost(
      reduced: json['reduced'] as int, id: json['id'] as String);
}

abstract class _$CivilizationAdvanceReducedCostSerializerMixin {
  int get reduced;
  String get id;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'reduced': reduced, 'id': id};
}

ColorCredit _$ColorCreditFromJson(Map<String, dynamic> json) {
  return new ColorCredit()
    ..group = $enumDecodeNullable('CivilizationAdvanceGroup',
        CivilizationAdvanceGroup.values, json['group'] as String)
    ..value = json['value'] as int;
}

abstract class _$ColorCreditSerializerMixin {
  CivilizationAdvanceGroup get group;
  int get value;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'group': group?.toString()?.split('.')?.last,
        'value': value
      };
}
