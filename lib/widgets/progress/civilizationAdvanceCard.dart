import 'package:flutter/material.dart';
import 'package:mega_civ_rules/models/civilizationadvance.dart';

typedef void OnTapCivilizationAdvanceCard(CivilizationAdvance advance);

class CivilizationAdvanceCard extends StatelessWidget {
  CivilizationAdvanceCard({this.advance, this.onTap, this.buttonText});

  final CivilizationAdvance advance;
  final OnTapCivilizationAdvanceCard onTap;
  final String buttonText;

  List<Widget> getGroupImages() {
    return advance.groups.map((g) {
      String fileSrc = g.toString().replaceAll("CivilizationAdvanceGroup.", "");
      return Image(
          alignment: Alignment.topLeft,
          width: 30.0,
          image: AssetImage("assets/img/advancegroups/$fileSrc.png"));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    AnimationController _controller;
    Card card = Card(
        child: new Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
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
          subtitle: Container(
            padding: EdgeInsets.only(left: 10.0, top: 10.0),
            child: Text(advance.attributes.join('\n\n')),
          ),
        ),
        new ButtonTheme.bar(
          // make buttons use the appropriate styles for cards
          child: new ButtonBar(
            children: <Widget>[
              new FlatButton(
                child: Text(this.buttonText),
                onPressed: () {
                  this.onTap(advance);
                },
              ),
            ],
          ),
        ),
      ],
    ));
    return card;
  }
}
