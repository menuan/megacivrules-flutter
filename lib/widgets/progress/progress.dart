import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'dart:convert';

import 'package:mega_civ_rules/models/data/civilizationadvance.dart';
import 'package:mega_civ_rules/services/civilizationAdvanceService.dart';
import 'package:mega_civ_rules/services/imageMemoization.dart';
import 'package:mega_civ_rules/widgets/progress/civilizationAdvanceCard.dart';
import 'package:mega_civ_rules/widgets/progress/progressHeader.dart';
import 'package:mega_civ_rules/models/viewmodels/civilizationAdvanceViewModel.dart';

enum ProgressDisplayMode { DetailedCard, Card }

class Progress extends StatefulWidget {
  Progress({Key key}) : super(key: key);

  @override
  _ProgressState createState() => new _ProgressState();
}

class _ProgressState extends State<Progress> {
  List<CivilizationAdvance> advances = [];
  List<String> acquired = [];
  ProgressDisplayMode mode = ProgressDisplayMode.DetailedCard;
  Map<String, Uint8List> decoded = Map();

  @override
  void initState() {
    super.initState();
    CivilizationAdvanceService.getAcquired().then((acquired) {
      this.setState(() {
        this.acquired = acquired;
      });
    });
    CivilizationAdvanceService.get().then((advances) {
      this.setState(() {
        this.advances = advances;
        _sort();
      });
    });
  }

  void _onTapAddRemoveAdvance(CivilizationAdvance advance, bool add) {
    this.setState(() {
      if (add) {
        this.acquired.add(advance.id);
      } else {
        this.acquired.remove(advance.id);
      }
      CivilizationAdvanceService.setAcquired(this.acquired);
    });
  }

  int _advancesSort(CivilizationAdvance a, CivilizationAdvance b) {
    int sort = a.cost - b.cost;
    if (sort < 0) return -1;
    if (sort > 0) return 1;
    return sort;
  }

  void _sort() {
    advances.sort(_advancesSort);
  }

  void _showModal(CivilizationAdvance a) {
    var data = ImageMemoization.instance.getImage(a.name);
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext modalContext) {
          return Container(
              child: Padding(
                  padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: Image.memory(data)));
        });
  }

  void _onChangeDisplayMode(ProgressDisplayMode mode) {
    setState(() {
      this.mode = mode;
    });
  }

  Widget _getCardGrid(BuildContext context) {
    return Expanded(
        child: GridView.count(
      primary: false,
      padding: const EdgeInsets.all(10.0),
      crossAxisSpacing: 10.0,
      mainAxisSpacing: 15.0,
      crossAxisCount: 2,
      children: advances
          .map((a) => GestureDetector(
                child: Image.memory(ImageMemoization.instance.getImage(a.name)),
                onTap: () => this._showModal(a),
              ))
          .toList(),
    ));
  }

  Widget _getDetailedCard() {
    Map<String, CivilizationAdvance> allAdvancesMap = Map.fromIterable(advances,
        key: (item) => item.id, value: (item) => item);
    var advancesList = new ListView.builder(
      itemBuilder: (context, i) => new CivilizationAdvanceCard(
            viewModel: new CivilizationAdvanceViewModel(
                allAdvances: allAdvancesMap ?? Map(),
                advance: advances[i],
                acquired: acquired),
            onTapAddRemove: _onTapAddRemoveAdvance,
            onTapShowCard: _showModal,
          ),
      itemCount: advances.length,
    );
    List<Widget> cardLists = [new Expanded(child: advancesList)];
    return Expanded(
        child: Column(children: [Expanded(child: Row(children: cardLists))]));
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      ProgressHeader(
          onChangeMode: _onChangeDisplayMode,
          mode: mode,
          advances: this.advances.where((advance) {
            return this.acquired.contains(advance.id);
          }).toList())
    ];
    switch (mode) {
      case ProgressDisplayMode.Card:
        children.add(_getCardGrid(context));
        break;
      case ProgressDisplayMode.DetailedCard:
        children.add(_getDetailedCard());
        break;
    }
    return Column(children: children);
  }
}
