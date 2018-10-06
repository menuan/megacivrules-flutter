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
          const ListTile(
              leading: const Icon(Icons.album),
              title: const Text('Current progreess'),
              subtitle: null),
          Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 20.0, bottom: 20.0),
              child: Text(
                "Victory points: ${getVictoryPoints()}",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 20.0),
              ))
        ],
      ),
    );
  }
}
