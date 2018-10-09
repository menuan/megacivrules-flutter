import 'dart:typed_data';
import 'dart:convert';

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
        var acquiredAdvance = allAdvances[id];
        if (acquiredAdvance != null) {
          var reduced = acquiredAdvance.reduceCosts.firstWhere((r) {
            return r.id == advance.id;
          }, orElse: () => null);
          if (reduced != null) {
            reducedSum += reduced.reduced;
          }
          acquiredAdvance.colorCredits.forEach((colorCredit) {
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

  String getAdvanceName() {
    return advance.name;
  }

  CivilizationAdvance getAdvance() {
    return advance;
  }
}
