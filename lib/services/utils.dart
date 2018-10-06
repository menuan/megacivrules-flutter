import 'package:flutter/services.dart' show rootBundle;
import 'dart:async' show Future;

class Utils {
  static Future<String> loadJSONAsset(String src) async {
    return await rootBundle.loadString('assets/data/json/$src');
  }
}
