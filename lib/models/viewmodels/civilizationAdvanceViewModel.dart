import 'package:mega_civ_rules/models/data/civilizationadvance.dart';

class CivilizationAdvanceViewModel {
  CivilizationAdvanceViewModel({this.allAdvances, this.advance, this.acquired});

  final Map<String, CivilizationAdvance> allAdvances;
  final CivilizationAdvance advance;
  final List<String> acquired;

  int calculateReducedCost() {
    if (acquired.length > 0) {
      int reducedSum = 0;
      acquired.forEach((id) {
        var advance = allAdvances[id];
        if (advance != null) {
          var reduced = advance.reduceCosts.firstWhere((r) {
            return r.id == advance.id;
          }, orElse: () => null);
          if (reduced != null) {
            reducedSum += reduced.reduced;
          }
          advance.colorCredits.forEach((colorCredit) {
            if (advance.groups.contains(colorCredit.group)) {
              reducedSum += colorCredit.value;
            }
          });
        }
      });
      return (advance.cost - reducedSum);
    }
    return advance.cost;
  }

  bool isAcquired() {
    return this.acquired.contains(advance.id);
  }

  List<String> getReducedCostStrings() {
    if (advance.reduceCosts != null &&
        advance.reduceCosts.length > 0 &&
        allAdvances != null) {
      print(advance.reduceCosts);
      return advance.reduceCosts.map((r) {
        CivilizationAdvance other = allAdvances[r.id];
        if (other != null) {
          return "${other.name}: ${r.reduced}";
        }
        return "";
      }).toList();
    }
    return List();
  }

  int getAdvanceCost() {
    return advance.cost;
  }

  String getAdvanceAttributes() {
    return advance.attributes.join('\n\n');
  }

  bool hasReduceCosts() {
    return advance.reduceCosts != null && advance.reduceCosts.length > 0;
  }

  String getAdvanceName() {
    return advance.name;
  }

  CivilizationAdvance getAdvance() {
    return advance;
  }

  String getAdvanceVictoryPoints() {
    return advance.victoryPoints.toString();
  }

  bool hasColorCredits() {
    return advance.colorCredits != null && advance.colorCredits.length > 0;
  }

  String getColorCreditString() {
    return advance.colorCredits
        .map((c) => "${c.group.toString().split('.')?.last}: ${c.value}")
        .join(", ");
  }

  String getImage() {
    return "imgsrc";
  }
}
