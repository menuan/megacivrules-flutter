import 'package:flutter/material.dart';

import 'package:mega_civ_rules/models/data/civilizationadvance.dart';
import 'package:mega_civ_rules/services/imageMemoization.dart';

typedef void OnTapCivilizationAdvanceCardAddRemove(
    CivilizationAdvance advance, bool add);
typedef void OnTapCivilizationAdvanceCardShowCard(CivilizationAdvance advance);

class CivilizationAdvanceCard extends StatelessWidget {
  CivilizationAdvanceCard(
      {this.onTapAddRemove,
      this.advance,
      this.onTapShowCard,
      this.isAcquired,
      this.cost});

  final OnTapCivilizationAdvanceCardAddRemove onTapAddRemove;
  final CivilizationAdvance advance;
  final OnTapCivilizationAdvanceCardShowCard onTapShowCard;
  final bool isAcquired;
  final int cost;

  String getButtonText() {
    if (this.isAcquired) {
      return "Remove";
    } else {
      return "Add";
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    Widget reduced;
    if (!this.isAcquired && cost != advance.cost) {
      reduced = Text(
        "Reduced cost: $cost",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
      );
    }
    children.add(ListTile(trailing: reduced, title: Text(advance.name)));
    var data = ImageMemoization.instance.getImage(advance.id);
    children.add(Padding(
        padding:
            EdgeInsets.only(left: 50.0, right: 50.0, top: 20.0, bottom: 25.0),
        child: GestureDetector(
            onTap: () => onTapShowCard(advance), child: Image.memory(data))));
    children.add(RaisedButton(
        child: Text(getButtonText()),
        onPressed: () => this.onTapAddRemove(advance, !this.isAcquired)));
    Card card = Card(
        color: this.isAcquired
            ? Theme.of(context).primaryColor
            : Theme.of(context).cardColor,
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: children,
        ));
    return card;
  }
}
