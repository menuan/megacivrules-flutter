import 'dart:convert';
import 'package:mega_civ_rules/models/data/chapter.dart';
import 'package:mega_civ_rules/services/utils.dart';
import 'dart:async' show Future;

class ChapterService {
  static Future<List<Chapter>> get() {
    return Utils.loadJSONAsset("chapters.json").then((val) {
      var chapters = List<Chapter>();
      List<dynamic> chaptersJson = json.decode(val);
      chaptersJson.forEach((d) => chapters.add(Chapter.fromJson(d)));
      return chapters;
    });
  }
}
