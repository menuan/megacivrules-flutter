import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mega_civ_rules/models/civilizationadvance.dart';

class ProgressHeader extends StatelessWidget {
  ProgressHeader({this.advances});
  final List<CivilizationAdvance> advances;
  bool filter = false;
  String getVictoryPoints() {
    if (advances.length > 0) {
      return advances
          .map((a) => a.victoryPoints)
          .reduce((value, element) => value + element)
          .toString();
    }
    return "0";
  }

  void onChangeFilter(bool val) {
    this.filter = val;
  }

  @override
  Widget build(BuildContext context) {
    return new Card(
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
              leading: Icon(Icons.stars),
              title: Text("Victory points: ${getVictoryPoints()}"),
              subtitle: null),
        ],
      ),
    );
  }
}
