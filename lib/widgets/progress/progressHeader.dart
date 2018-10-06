import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mega_civ_rules/models/civilizationadvance.dart';

class ProgressHeader extends StatelessWidget {
  ProgressHeader({this.advances});
  final List<CivilizationAdvance> advances;

  String getVictoryPoints() {
    if (advances.length > 0) {
      return advances
          .map((a) => a.victoryPoints)
          .reduce((value, element) => value + element)
          .toString();
    }
    return "0";
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Card(
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
              leading: const Icon(Icons.album),
              title: Text("Victory points: ${getVictoryPoints()}"),
              subtitle: null)
        ],
      ),
    );
  }
}
