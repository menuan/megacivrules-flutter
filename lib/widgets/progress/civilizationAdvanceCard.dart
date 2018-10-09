import 'package:flutter/material.dart';
import 'package:mega_civ_rules/models/data/civilizationadvance.dart';
import 'package:mega_civ_rules/models/viewmodels/civilizationAdvanceViewModel.dart';

typedef void OnTapCivilizationAdvanceCard(
    CivilizationAdvance advance, bool add);

class CivilizationAdvanceCard extends StatelessWidget {
  CivilizationAdvanceCard({this.onTap, this.viewModel});

  final OnTapCivilizationAdvanceCard onTap;
  final CivilizationAdvanceViewModel viewModel;

  String getButtonText() {
    if (viewModel.isAcquired()) {
      return "Remove";
    } else {
      return "Add";
    }
  }

  Widget getDiscount(BuildContext context) {
    var chips = Row(
        children: viewModel.getReducedCostStrings().map((title) {
      return Container(
          padding: EdgeInsets.only(left: 5.0),
          child: Chip(
            backgroundColor: Theme.of(context).chipTheme.secondarySelectedColor,
            label: new Text(
              '$title',
              overflow: TextOverflow.fade,
              style: TextStyle(color: Colors.white),
            ),
          ));
    }).toList());
    return Column(children: [chips]);
  }

  void showModal(BuildContext context) {
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext modalContext) {
          return Container(
              child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Text(
                      'TODO: Show card image... ${viewModel.getImage()}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Theme.of(modalContext).accentColor,
                          fontSize: 24.0))));
        });
  }

  Widget getFooter(BuildContext context) {
    return new ButtonTheme.bar(
      // make buttons use the appropriate styles for cards
      child: new ButtonBar(
        children: <Widget>[
          new RaisedButton(
            child: const Text('Card'),
            onPressed: () {
              this.showModal(context);
            },
          ),
          new RaisedButton(
            child: Text(getButtonText()),
            onPressed: () {
              this.onTap(viewModel.getAdvance(), !viewModel.isAcquired());
            },
          ),
        ],
      ),
    );
  }

  Widget getHeader() {
    return ListTile(
        trailing: Text(
            "Cost: ${viewModel.getAdvanceCost()} \nVictory points: ${viewModel.getAdvanceVictoryPoints()}"),
        title: Text(viewModel.getAdvanceName()));
  }

  List<Widget> getContent(BuildContext context) {
    int reducedCost = !viewModel.isAcquired()
        ? viewModel.calculateReducedCost()
        : viewModel.getAdvanceCost();
    List<Widget> content = [
      ListTile(
        title: Container(
            padding: EdgeInsets.only(left: 10.0),
            child: reducedCost != viewModel.getAdvanceCost()
                ? Text(
                    "Reduced cost: $reducedCost",
                    style: TextStyle(fontSize: 15.0, color: Colors.green[400]),
                  )
                : null),
        subtitle: Container(
          padding: EdgeInsets.only(left: 10.0, top: 10.0),
          child: Text(viewModel.getAdvanceAttributes()),
        ),
      )
    ];
    if (viewModel.hasColorCredits()) {
      content.add(ListTile(
          title: null,
          subtitle: Container(child: Text(viewModel.getColorCreditString()))));
    }
    if (viewModel.hasReduceCosts()) {
      content.add(getDiscount(context));
    }
    return content;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    children.add(getHeader());
    children.addAll(getContent(context));
    children.add(getFooter(context));
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
