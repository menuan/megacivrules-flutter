import 'dart:convert';
import 'package:mega_civ_rules/models/data/chapter.dart';
import 'package:mega_civ_rules/services/utils.dart';
import 'dart:async' show Future, Completer;

class ChapterService {
  static Future<List<Chapter>> get() {
    var completer = Completer<List<Chapter>>();
    Utils.loadJSONAsset("chapters.json").then((val) {
      var chapters = List<Chapter>();
      List<dynamic> chaptersJson = json.decode(val);
      chaptersJson.forEach((d) => chapters.add(Chapter.fromJson(d)));
      completer.complete(chapters);
    });
    return completer.future;
  }
}
