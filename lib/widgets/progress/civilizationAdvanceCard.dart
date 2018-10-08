import 'package:flutter/material.dart';
import 'package:mega_civ_rules/models/civilizationadvance.dart';

typedef void OnTapCivilizationAdvanceCard(
    CivilizationAdvance advance, bool add);

class CivilizationAdvanceCard extends StatelessWidget {
  CivilizationAdvanceCard(
      {this.advance,
      this.allAdvances,
      this.acquired,
      this.onTap,
      this.shouldRenderReducedCost});

  final CivilizationAdvance advance;
  final Map<String, CivilizationAdvance> allAdvances;
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
    return advance.calculateReducedCost(acquired, this.allAdvances);
  }

  Widget getDiscount(BuildContext context) {
    var chips = Row(
        children: advance.reduceCosts.map((r) {
      String title = "${allAdvances[r.id].name}: ${r.reduced}";
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
                  child: Text('TODO: Show card image...',
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
              this.onTap(advance, !isAcquired());
            },
          ),
        ],
      ),
    );
  }

  Widget getHeader() {
    return ListTile(
        trailing: Text(
            "Cost: ${advance.cost.toString()} \nVictory points: ${advance.victoryPoints.toString()}"),
        title: Text(advance.name));
  }

  List<Widget> getContent(BuildContext context) {
    int reducedCost = !isAcquired() ? getReducedCost() : advance.cost;
    List<Widget> content = [
      ListTile(
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
      )
    ];
    if (advance.reduceCosts != null && advance.reduceCosts.length > 0) {
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
