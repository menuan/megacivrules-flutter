import 'package:flutter/material.dart';
import 'package:mega_civ_rules/models/civilizationadvance.dart';

typedef void OnTapCivilizationAdvanceCard(CivilizationAdvance advance);

class CivilizationAdvanceCard extends StatelessWidget {
  CivilizationAdvanceCard(
      {this.advance,
      this.advances,
      this.onTap,
      this.buttonText,
      this.shouldRenderReducedCost});

  final CivilizationAdvance advance;
  final List<CivilizationAdvance> advances;
  final OnTapCivilizationAdvanceCard onTap;
  final String buttonText;
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

  int getReducedCost() {
    return advance.calculateReducedCost(this.advances);
  }

  Widget getFooterButton() {
    return new ButtonTheme.bar(
      // make buttons use the appropriate styles for cards
      child: new ButtonBar(
        children: <Widget>[
          new RaisedButton(
            color: Colors.amber,
            textColor: Colors.white,
            child: Text(this.buttonText),
            onPressed: () {
              this.onTap(advance);
            },
          ),
        ],
      ),
    );
  }

  Widget getDiscount() {
    return ListTile(
      title: Container(
          padding: EdgeInsets.only(left: 10.0),
          child: Text(
            "Discounts:",
            style: TextStyle(fontSize: 15.0, color: Colors.black),
          )),
      subtitle: Container(
          padding: EdgeInsets.only(left: 10.0, top: 10.0),
          child: Row(
              children: advance.reduceCosts.map((r) {
            String title = "${r.id}: ${r.reduced}";
            return Container(
                padding: EdgeInsets.only(left: 5.0),
                child: Chip(
                  backgroundColor: Colors.green,
                  label: new Text(
                    '$title',
                    style: TextStyle(color: Colors.white),
                  ),
                ));
          }).toList())),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      ListTile(leading: null, title: Text(advance.name)),
      Container(
          width: double.infinity,
          height: 30.0,
          padding: EdgeInsets.only(left: 20.0),
          child: Row(children: getGroupImages())),
      ListTile(
        title: Container(
            padding: EdgeInsets.only(left: 10.0, top: 10.0),
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
      children.add(getDiscount());
    }
    children.add(getFooterButton());

    Card card = Card(
        child: new Column(
      mainAxisSize: MainAxisSize.min,
      children: children,
    ));
    return card;
  }
}
