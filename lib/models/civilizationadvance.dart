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
  List<CivilizationAdvanceReducedCost> reduceCosts;
  String id;
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
