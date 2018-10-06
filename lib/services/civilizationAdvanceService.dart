import 'dart:convert';
import 'package:mega_civ_rules/models/civilizationadvance.dart';
import 'package:mega_civ_rules/services/utils.dart';
import 'dart:async' show Future;

class CivilizationAdvanceService {
  static Future<List<CivilizationAdvance>> get() {
    return Utils.loadJSONAsset("civilizationadvances.json").then((val) {
      var advances = List<CivilizationAdvance>();
      List<dynamic> advanceJson = json.decode(val);
      advanceJson.forEach((a) => advances.add(CivilizationAdvance.fromJson(a)));
      return advances;
    });
  }
}
