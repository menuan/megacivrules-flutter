import 'package:flutter/services.dart' show rootBundle;
import 'dart:async' show Future;

import 'package:flutter/material.dart';

class Utils {
  static Future<String> loadJSONAsset(String src) async {
    return await rootBundle.loadString('assets/data/json/$src');
  }

  static List<TextSpan> getMassagedTexts(String content, String searchPattern) {
    List<TextSpan> spans = [];
    final defaultStyle =
        TextStyle(fontWeight: FontWeight.normal, color: Colors.white);
    if (searchPattern != null && searchPattern.length > 2) {
      final contentList =
          content.toLowerCase().split(searchPattern.toLowerCase());
      final contentListLength = contentList.length;
      final matches = contentList.length > 1 ? contentList.length - 1 : 0;
      final searchMatchStyle =
          TextStyle(fontWeight: FontWeight.bold, color: Colors.redAccent);
      print("Search pattern is not nil and we have: $contentList, $matches");
      if (matches > 0) {
        print("More than 0 matches!");
//        contentList.forEach((content) {});
        for (var i = 0; i < contentListLength; i++) {
          var content = contentList[i];
          spans.add(TextSpan(style: defaultStyle, text: content));
          if ((contentListLength - 1) != i) {
            spans.add(TextSpan(style: searchMatchStyle, text: searchPattern));
          }
        }
      } else {
        spans.add(TextSpan(style: defaultStyle, text: content));
      }
    } else {
      spans.add(TextSpan(style: defaultStyle, text: content));
    }
    return spans;
  }
}
