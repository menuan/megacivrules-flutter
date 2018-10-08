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
    // TODO: implement build
    return new Card(
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
              leading: null,
              title: Text("Victory points: ${getVictoryPoints()}"),
              subtitle: null),
          Row(children: [
            Checkbox(
              value: this.filter,
              onChanged: onChangeFilter,
              tristate: false,
            ),
            Checkbox(
              value: this.filter,
              onChanged: onChangeFilter,
              tristate: false,
            ),
            Checkbox(
              value: this.filter,
              onChanged: onChangeFilter,
              tristate: false,
            )
          ])
        ],
      ),
    );
  }
}
