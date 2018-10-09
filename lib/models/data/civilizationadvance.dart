import 'package:json_annotation/json_annotation.dart';
part 'package:mega_civ_rules/models/data/civilizationadvance.g.dart';

enum CivilizationAdvanceGroup { science, arts, crafts, civic, religion }

@JsonSerializable()
class CivilizationAdvance extends Object
    with _$CivilizationAdvanceSerializerMixin {
  List<CivilizationAdvanceGroup> groups;
  int victoryPoints;
  int cost;
  List<String> attributes;
  String name;
  List<CivilizationAdvanceReducedCost> reduceCosts;
  String id;
  List<ColorCredit> colorCredits;

  // TODO: Additional credits, if present, specified as attributes
  CivilizationAdvance(
      {this.groups,
      this.victoryPoints,
      this.cost,
      this.attributes,
      this.name,
      this.id});

  factory CivilizationAdvance.fromJson(Map<String, dynamic> json) =>
      _$CivilizationAdvanceFromJson(json);

  int calculateReducedCost(
      List<String> acquiredIds, Map<String, CivilizationAdvance> allAdvances) {
    if (acquiredIds.length > 0) {
      int reducedSum = 0;
      acquiredIds.forEach((id) {
        var advance = allAdvances[id];
        if (advance != null) {
          var reduced = advance.reduceCosts.firstWhere((r) {
            return r.id == this.id;
          }, orElse: () => null);
          if (reduced != null) {
            reducedSum += reduced.reduced;
          }
          advance.colorCredits.forEach((colorCredit) {
            if (this.groups.contains(colorCredit.group)) {
              reducedSum += colorCredit.value;
            }
          });
        }
      });
      return (cost - reducedSum);
    }
    return cost;
  }
}

@JsonSerializable()
class CivilizationAdvanceReducedCost extends Object
    with _$CivilizationAdvanceReducedCostSerializerMixin {
  CivilizationAdvanceReducedCost({this.reduced, this.id});
  int reduced;
  String id;

  factory CivilizationAdvanceReducedCost.fromJson(Map<String, dynamic> json) =>
      _$CivilizationAdvanceReducedCostFromJson(json);
}

@JsonSerializable()
class ColorCredit extends Object with _$ColorCreditSerializerMixin {
  ColorCredit();

  CivilizationAdvanceGroup group;
  int value;

  factory ColorCredit.fromJson(Map<String, dynamic> json) =>
      _$ColorCreditFromJson(json);
}
