import 'package:flutter/material.dart';
import 'package:mega_civ_rules/models/civilizationadvance.dart';
import 'package:mega_civ_rules/services/civilizationAdvanceService.dart';
import 'package:mega_civ_rules/widgets/progress/civilizationAdvanceCard.dart';

class Progress extends StatefulWidget {
  Progress({Key key}) : super(key: key);

  @override
  _ProgressState createState() => new _ProgressState();
}

class _ProgressState extends State<Progress> {
  List<CivilizationAdvance> advances = [];
  List<CivilizationAdvance> acquired = [];

  @override
  void initState() {
    super.initState();
    CivilizationAdvanceService.get().then((advances) {
      this.setState(() {
        this.advances = advances;
      });
    });
  }

  void onTapAdvanceAdd(CivilizationAdvance advance) {
    this.setState(() {
      advances.remove(advance);
      acquired.add(advance);
    });
  }

  void onTapAdvanceRemove(CivilizationAdvance advance) {
    this.setState(() {
      acquired.remove(advance);
      advances.add(advance);
    });
  }

  @override
  Widget build(BuildContext context) {
    var advancesList = new ListView.builder(
      itemBuilder: (context, i) => new CivilizationAdvanceCard(
          advance: advances[i], onTap: onTapAdvanceAdd, buttonText: "Add"),
      itemCount: advances.length,
    );
    var acquiredList = new ListView.builder(
      itemBuilder: (context, i) => new CivilizationAdvanceCard(
          advance: acquired[i],
          onTap: onTapAdvanceRemove,
          buttonText: "Remove"),
      itemCount: acquired.length,
    );
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10.0),
      child: Row(
        children: [
          new Expanded(child: advancesList),
          new Expanded(child: acquiredList)
        ],
      ),
    );
  }
}
