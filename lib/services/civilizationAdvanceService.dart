import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async' show Future;

import 'package:mega_civ_rules/models/data/civilizationadvance.dart';
import 'package:mega_civ_rules/services/utils.dart';
import 'package:mega_civ_rules/services/imageMemoization.dart';

class CivilizationAdvanceService {
  static String acquiredKey = "acquired";

  static Future<List<CivilizationAdvance>> get() {
    ImageMemoization imgCache = ImageMemoization.instance;
    return Utils.loadJSONAsset("civilizationadvances.json").then((val) {
      var advances = List<CivilizationAdvance>();
      List<dynamic> advanceJson = json.decode(val);
      advanceJson.forEach((a) {
        var decoded = CivilizationAdvance.fromJson(a);
        advances.add(decoded);
        imgCache.setImage(decoded.name, decoded.image);
      });
      return advances;
    });
  }

  static Future<List<String>> getAcquired() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> acquired = prefs.getStringList(acquiredKey);
    return Future(() => acquired ?? []);
  }

  static void setAcquired(List<String> acquired) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(acquiredKey, acquired);
  }
}
