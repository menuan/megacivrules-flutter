import 'package:flutter/material.dart';

import 'package:mega_civ_rules/models/data/civilizationadvance.dart';
import 'package:mega_civ_rules/models/viewmodels/civilizationAdvanceViewModel.dart';
import 'package:mega_civ_rules/services/imageMemoization.dart';

typedef void OnTapCivilizationAdvanceCardAddRemove(
    CivilizationAdvance advance, bool add);
typedef void OnTapCivilizationAdvanceCardShowCard(CivilizationAdvance advance);

class CivilizationAdvanceCard extends StatelessWidget {
  CivilizationAdvanceCard(
      {this.onTapAddRemove, this.viewModel, this.onTapShowCard});

  final OnTapCivilizationAdvanceCardAddRemove onTapAddRemove;
  final CivilizationAdvanceViewModel viewModel;
  final OnTapCivilizationAdvanceCardShowCard onTapShowCard;

  String getButtonText() {
    if (viewModel.isAcquired()) {
      return "Remove";
    } else {
      return "Add";
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    int reducedCost = viewModel.calculateReducedCost();
    Widget reduced;
    if (!viewModel.isAcquired() && reducedCost != viewModel.getAdvanceCost()) {
      reduced = Text(
        "Reduced cost: $reducedCost",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
      );
    }
    children.add(
        ListTile(trailing: reduced, title: Text(viewModel.getAdvanceName())));
    var data = ImageMemoization.instance.getImage(viewModel.getAdvance().id);
    children.add(Padding(
        padding:
            EdgeInsets.only(left: 50.0, right: 50.0, top: 20.0, bottom: 25.0),
        child: GestureDetector(
            onTap: () => onTapShowCard(viewModel.getAdvance()),
            child: Image.memory(data))));
    children.add(RaisedButton(
        child: Text(getButtonText()),
        onPressed: () => this.onTapAddRemove(
            viewModel.getAdvance(), !this.viewModel.isAcquired())));
    Card card = Card(
        color: viewModel.isAcquired()
            ? Theme.of(context).primaryColor
            : Theme.of(context).cardColor,
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: children,
        ));
    return card;
  }
}
