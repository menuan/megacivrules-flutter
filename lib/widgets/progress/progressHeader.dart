import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mega_civ_rules/models/data/civilizationadvance.dart';
import 'package:mega_civ_rules/widgets/progress/progress.dart';

typedef void OnChangeProgressMode(ProgressDisplayMode mode);

class ProgressHeader extends StatelessWidget {
  ProgressHeader({this.advances, this.onChangeMode, this.mode});
  final List<CivilizationAdvance> advances;
  final OnChangeProgressMode onChangeMode;
  final ProgressDisplayMode mode;

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
    return new Card(
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
              leading: Icon(Icons.stars),
              trailing: Column(
                children: <Widget>[
                  GestureDetector(
                      onTap: () => this.onChangeMode(
                          this.mode == ProgressDisplayMode.DetailedCard
                              ? ProgressDisplayMode.Card
                              : ProgressDisplayMode.DetailedCard),
                      child: Icon(mode == ProgressDisplayMode.DetailedCard
                          ? Icons.grid_on
                          : Icons.list))
                ],
              ),
              title: Text("Victory points: ${getVictoryPoints()}"),
              subtitle: null),
        ],
      ),
    );
  }
}
