import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async' show Future, Completer;

import 'package:mega_civ_rules/models/data/civilizationadvance.dart';
import 'package:mega_civ_rules/services/utils.dart';
import 'package:mega_civ_rules/services/imageMemoization.dart';

typedef OnComplete(List<String> acquiered);

class CivilizationAdvanceService {
  static String acquiredKey = "acquired";
  static List<CivilizationAdvance> advances = [];
  static bool loaded = false;

  static Future<List<CivilizationAdvance>> get() async {
    var completer = new Completer<List<CivilizationAdvance>>();
    ImageMemoization imgCache = ImageMemoization.instance;
    if (!loaded) {
      Utils.loadJSONAsset("civilizationadvances.json").then((val) {
        var advances = List<CivilizationAdvance>();
        List<dynamic> advanceJson = json.decode(val);
        advanceJson.forEach((a) {
          var decoded = CivilizationAdvance.fromJson(a);
          advances.add(decoded);
          imgCache.setImage(decoded.id, decoded.image);
        });
        CivilizationAdvanceService.advances = advances;
        loaded = true;
        completer.complete(advances);
      });
    } else {
      completer.complete(advances != null ? advances : List());
    }
    return completer.future;
  }

  static Future<List<String>> getAcquired() async {
    var completer = new Completer<List<String>>();
    SharedPreferences.getInstance().then((prefs) {
      List<String> acquired = prefs.getStringList(acquiredKey);
      completer.complete(acquired != null ? acquired : List());
    });
    return completer.future;
  }

  static void setAcquired(List<String> acquired) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(acquiredKey, acquired);
  }
}
