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
  // TODO: Additional credits, if present, specified as attributes
  CivilizationAdvance(
      {this.groups, this.victoryPoints, this.cost, this.attributes, this.name});

  factory CivilizationAdvance.fromJson(Map<String, dynamic> json) =>
      _$CivilizationAdvanceFromJson(json);

  int calculateReducedCost(List<CivilizationAdvance> acquired) {
    if (acquired != null && acquired.length > 0) {
      int reducedSum = 0;
      acquired.forEach((a) {
        a.reduceCosts.forEach((reduced) {
          if (reduced.id == this.name) {
            reducedSum += reduced.reduced;
          }
        });
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
