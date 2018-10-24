import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async' show Future, Completer;

import 'package:mega_civ_rules/models/data/civilizationadvance.dart';
import 'package:mega_civ_rules/services/utils.dart';
import 'package:mega_civ_rules/services/imageMemoization.dart';
import 'package:flutter/foundation.dart';
import 'dart:typed_data';

typedef OnComplete(List<String> acquiered);

class CivilizationAdvanceService {
  static String acquiredKey = "acquired";
  static List<CivilizationAdvance> advances = [];
  static bool loaded = false;

  static List<CivilizationAdvance> _parseAdvances(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<CivilizationAdvance>((json) {
      var advance = CivilizationAdvance.fromJson(json);
      return advance;
    }).toList();
  }

  static Map<String, Uint8List> _decodeImages(
      List<CivilizationAdvance> advances) {
    Map<String, Uint8List> map = Map();
    advances.forEach((a) {
      var image = Base64Decoder().convert(a.image);
      map[a.id] = image;
    });
    return map;
  }

  static Future<List<CivilizationAdvance>> get() async {
    var completer = new Completer<List<CivilizationAdvance>>();
    ImageMemoization imgCache = ImageMemoization.instance;
    if (!loaded) {
      Utils.loadJSONAsset("civilizationadvances.json").then((val) async {
        var decoded = await compute(_parseAdvances, val);
        var images = await compute(_decodeImages, decoded);
        images.forEach((key, value) {
          imgCache.setImage(key, value);
        });
        advances = decoded;
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
