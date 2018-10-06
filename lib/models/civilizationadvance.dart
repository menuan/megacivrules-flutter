import 'package:json_annotation/json_annotation.dart';
part 'civilizationadvance.g.dart';

enum CivilizationAdvanceGroup { science, arts, crafts, civic, religion }

@JsonSerializable()
class CivilizationAdvance extends Object
    with _$CivilizationAdvanceSerializerMixin {
  List<CivilizationAdvanceGroup> groups;
  int victoryPoints;
  int cost;
  List<String> attributes;
  String name;
  // TODO: add - Specific credits to a single card, Additional credits, if present, specified as attributes
  CivilizationAdvance(
      {this.groups, this.victoryPoints, this.cost, this.attributes, this.name});

  factory CivilizationAdvance.fromJson(Map<String, dynamic> json) =>
      _$CivilizationAdvanceFromJson(json);
}
