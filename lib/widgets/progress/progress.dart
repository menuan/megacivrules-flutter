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
  List<String> acquired = [];

  @override
  void initState() {
    super.initState();
    CivilizationAdvanceService.getAcquired().then((acquired) {
      this.setState(() {
        print(acquired);
        this.acquired = acquired;
      });
    });
    CivilizationAdvanceService.get().then((advances) {
      this.setState(() {
        this.advances = advances;
        sort();
      });
    });
  }

  void onTapAdvance(CivilizationAdvance advance, bool add) {
    this.setState(() {
      if (add) {
        this.acquired.add(advance.id);
      } else {
        this.acquired.remove(advance.id);
      }
      CivilizationAdvanceService.setAcquired(this.acquired);
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
  }

  void showModal(BuildContext context) {
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext modalContext) {
          return Container(
              child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Text(
                      'This is the modal bottom sheet. Tap anywhere to dismiss.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Theme.of(modalContext).accentColor,
                          fontSize: 24.0))));
        });
  }

  @override
  Widget build(BuildContext context) {
    var advancesList = new ListView.builder(
      itemBuilder: (context, i) => new CivilizationAdvanceCard(
          acquired: this.acquired,
          advance: advances[i],
          onTap: onTapAdvance,
          allAdvances: Map.fromIterable(advances,
              key: (item) => item.id, value: (item) => item),
          shouldRenderReducedCost: true),
      itemCount: advances.length,
    );

    List<Widget> cardLists = [new Expanded(child: advancesList)];
    return Column(children: [
      ProgressHeader(
          advances: this.advances.where((advance) {
        return this.acquired.contains(advance.id);
      }).toList()),
      Expanded(
          child: Column(children: [Expanded(child: Row(children: cardLists))]))
    ]);
  }
}
