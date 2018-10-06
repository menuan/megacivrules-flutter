import 'package:flutter/material.dart';
import 'package:mega_civ_rules/models/civilizationadvance.dart';
import 'package:mega_civ_rules/services/civilizationAdvanceService.dart';
import 'package:mega_civ_rules/widgets/progress/civilizationAdvanceCard.dart';
import 'package:mega_civ_rules/widgets/progress/progressHeader.dart';

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
        sort();
      });
    });
  }

  void onTapAdvanceAdd(CivilizationAdvance advance) {
    this.setState(() {
      advances.remove(advance);
      acquired.add(advance);
      sort();
    });
  }

  void onTapAdvanceRemove(CivilizationAdvance advance) {
    this.setState(() {
      acquired.remove(advance);
      advances.add(advance);
      sort();
    });
  }

  int advancesSort(CivilizationAdvance a, CivilizationAdvance b) {
    int sort = a.cost - b.cost;
    if (sort < 0) return -1;
    if (sort > 0) return 1;
    return sort;
  }

  void sort() {
    advances.sort(advancesSort);
    acquired.sort(advancesSort);
  }

  @override
  Widget build(BuildContext context) {
    var advancesList = new ListView.builder(
      itemBuilder: (context, i) => new CivilizationAdvanceCard(
          advances: this.advances,
          advance: advances[i],
          onTap: onTapAdvanceAdd,
          buttonText: "Add"),
      itemCount: advances.length,
    );
    var acquiredList = new ListView.builder(
      itemBuilder: (context, i) => new CivilizationAdvanceCard(
          advances: this.advances,
          advance: acquired[i],
          onTap: onTapAdvanceRemove,
          buttonText: "Remove"),
      itemCount: acquired.length,
    );

    List<Widget> cardLists = [
      new Expanded(child: advancesList),
      new Expanded(child: acquiredList)
    ];
    return Column(children: [
      ProgressHeader(advances: acquired),
      Expanded(
          child: Column(children: [Expanded(child: Row(children: cardLists))]))
    ]);
  }
}
