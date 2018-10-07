import 'package:flutter/material.dart';

class ThemeService {
  static List<MaterialColor> presetColors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.purple,
    Colors.amber,
    Colors.teal,
    Colors.blueGrey,
    Colors.cyan,
    Colors.lightBlue,
    Colors.lightGreen,
    Colors.lime
  ];

  static MaterialColor getColor(int index) {
    int max = presetColors.length;
    return presetColors[index % max];
  }
}
