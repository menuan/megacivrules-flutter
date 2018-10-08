import 'package:flutter/material.dart';
import 'package:mega_civ_rules/models/civilizationadvance.dart';
import 'package:mega_civ_rules/services/themeservice.dart';

typedef void OnTapCivilizationAdvanceCard(
    CivilizationAdvance advance, bool add);

class CivilizationAdvanceCard extends StatelessWidget {
  CivilizationAdvanceCard(
      {this.advance, this.acquired, this.onTap, this.shouldRenderReducedCost});

  final CivilizationAdvance advance;
  final List<String> acquired;
  final OnTapCivilizationAdvanceCard onTap;
  final bool shouldRenderReducedCost;

  List<Widget> getGroupImages() {
    return advance.groups.map((g) {
      String fileSrc = g.toString().replaceAll("CivilizationAdvanceGroup.", "");
      return Image(
          alignment: Alignment.topLeft,
          width: 30.0,
          image: AssetImage("assets/img/advancegroups/$fileSrc.png"));
    }).toList();
  }

  bool isAcquired() {
    return this.acquired.contains(advance.id);
  }

  String getButtonText() {
    if (isAcquired()) {
      return "Remove";
    } else {
      return "Add";
    }
  }

  int getReducedCost() {
    return advance.calculateReducedCost(this.acquired);
  }

  Widget getDiscount(BuildContext context) {
    var chips = Row(
        children: advance.reduceCosts.map((r) {
      String title = "${r.id}: ${r.reduced}";
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

  void onTapShowCard() {}

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      ListTile(
          trailing: Container(
              padding: EdgeInsets.only(top: 40.0),
              child: Column(children: [
                new RaisedButton(
//            color: Colors.purple,
                  textColor: Colors.white,
                  child: Text(getButtonText()),
                  onPressed: () {
                    this.onTap(advance, !isAcquired());
                  },
                ),
                new RaisedButton(
//            color: Colors.purple,
                  textColor: Colors.white,
                  child: Text("Show card"),
                  onPressed: () {
                    this.onTapShowCard();
                  },
                )
              ])),
          title: Text(advance.name)),
      /*Container(
          width: double.infinity,
          height: 30.0,
          padding: EdgeInsets.only(left: 20.0),
          child: Row(children: getGroupImages())),*/
      ListTile(
        title: Container(
            padding: EdgeInsets.only(left: 10.0, top: 0.0),
            child: Text(
                "Cost: ${advance.cost.toString()} \nVictory points: ${advance.victoryPoints.toString()}")),
        subtitle: null,
      )
    ];

    int reducedCost = getReducedCost();
    children.add(ListTile(
      title: Container(
          padding: EdgeInsets.only(left: 10.0),
          child: shouldRenderReducedCost && reducedCost != advance.cost
              ? Text(
                  "Reduced cost: $reducedCost",
                  style: TextStyle(fontSize: 15.0, color: Colors.green[400]),
                )
              : null),
      subtitle: Container(
        padding: EdgeInsets.only(left: 10.0, top: 10.0),
        child: Text(advance.attributes.join('\n\n')),
      ),
    ));

    if (advance.reduceCosts != null && advance.reduceCosts.length > 0) {
      children.add(getDiscount(context));
    }

    Card card = Card(
        color: isAcquired()
            ? Theme.of(context).primaryColor
            : Theme.of(context).cardColor,
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: children,
        ));
    return card;
  }
}
