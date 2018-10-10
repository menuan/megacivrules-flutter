import 'package:flutter/material.dart';

import 'package:mega_civ_rules/models/data/civilizationadvance.dart';
import 'package:mega_civ_rules/services/civilizationAdvanceService.dart';
import 'package:mega_civ_rules/services/imageMemoization.dart';
import 'package:mega_civ_rules/widgets/progress/civilizationAdvanceCard.dart';
import 'package:mega_civ_rules/models/viewmodels/civilizationAdvanceViewModel.dart';
import 'package:mega_civ_rules/widgets/CheckboxView/checkboxView.dart';

enum ProgressDisplayMode { DetailedCard, Card }

class Progress extends StatefulWidget {
  Progress({Key key}) : super(key: key);

  @override
  _ProgressState createState() => new _ProgressState();
}

class _ProgressState extends State<Progress>
    with AutomaticKeepAliveClientMixin<Progress> {
  bool get wantKeepAlive => true;
  List<CivilizationAdvance> advances = [];
  List<CivilizationAdvance> filteredAdvances = [];
  List<String> acquired = [];
  ProgressDisplayMode mode = ProgressDisplayMode.DetailedCard;
  Map<String, CivilizationAdvance> allAdvancesMap = Map();

  Map<CivilizationAdvanceGroup, bool> filter = Map();

  @override
  void initState() {
    super.initState();
    filter = {
      CivilizationAdvanceGroup.science: true,
      CivilizationAdvanceGroup.crafts: true,
      CivilizationAdvanceGroup.civic: true,
      CivilizationAdvanceGroup.arts: true,
      CivilizationAdvanceGroup.religion: true
    };
    CivilizationAdvanceService.getAcquired().then((acquired) {
      this.setState(() {
        this.acquired = acquired;
      });
    });
    CivilizationAdvanceService.get().then((advances) {
      this.setState(() {
        this.advances = advances;
        this.filteredAdvances = advances;
        allAdvancesMap = Map.fromIterable(advances,
            key: (item) => item.id, value: (item) => item);

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
    filteredAdvances.sort(_advancesSort);
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

  void _onChangeMode() {
    setState(() {
      mode = mode == ProgressDisplayMode.DetailedCard
          ? ProgressDisplayMode.Card
          : ProgressDisplayMode.DetailedCard;
    });
  }

  Widget _getCardGrid(BuildContext context) {
    return SliverGrid(
      gridDelegate: new SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200.0,
        mainAxisSpacing: 10.0,
      ),
      delegate: SliverChildBuilderDelegate(
          (context, pos) => GestureDetector(
                child: Image.memory(ImageMemoization.instance
                    .getImage(filteredAdvances[pos].name)),
                onTap: () => _showModal(filteredAdvances[pos]),
              ),
          childCount: filteredAdvances.length),
    );
  }

  Widget _getDetailedCardList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, pos) => _buildDetailedCardRow(context, filteredAdvances[pos]),
        childCount: filteredAdvances.length,
      ),
    );
  }

  Widget _buildDetailedCardRow(
      BuildContext context, CivilizationAdvance advance) {
    return new CivilizationAdvanceCard(
      viewModel: new CivilizationAdvanceViewModel(
          allAdvances: allAdvancesMap ?? Map(),
          advance: advance,
          acquired: acquired),
      onTapAddRemove: _onTapAddRemoveAdvance,
      onTapShowCard: _showModal,
    );
  }

  String getVictoryPoints() {
    if (advances.length > 0) {
      return advances
          .map((a) => a.victoryPoints)
          .reduce((value, element) => value + element)
          .toString();
    }
    return "0";
  }

  void _filterAdvances() {
    List<CivilizationAdvanceGroup> activeFilter = List();
    this.filter.forEach((g, val) {
      if (val) {
        activeFilter.add(g);
      }
    });
    print("_filterAdvances");
    this.setState(() {
      this.filteredAdvances = this.advances.where((a) {
        for (var g in a.groups) {
          if (activeFilter.contains(g)) {
            return true;
          }
        }
        return false;
      }).toList();
    });
  }

  Widget getSliverBar() {
    return SliverAppBar(
      floating: true,
      expandedHeight: 40.0,
      leading: null,
      automaticallyImplyLeading: false,
      actions: <Widget>[
        PopupMenuButton<String>(
          //onSelected: _select,
          onCanceled: () => _filterAdvances(),
          itemBuilder: (BuildContext context) {
            List<PopupMenuItem<String>> children = [];
            filter.forEach((group, val) {
              children.add(PopupMenuItem(
                  child: CheckboxView(
                      item: CheckBoxItem<CivilizationAdvanceGroup>(
                          onChange: (dynamic key, value) {
                            setState(() {
                              filter[key] = value;
                            });
                          },
                          key: group,
                          title: group
                              .toString()
                              .replaceAll("CivilizationAdvanceGroup.", ""),
                          value: filter[group]))));
              /*children.add(PopupMenuItem(
                  enabled: true,
                  child: Row(children: [
                    Checkbox(
                        value: filter[group],
                        onChanged: (val) => _selectedFilter(group)),
                    Text(
                        "${filter[group]}: ${group.toString().replaceAll("CivilizationAdvanceGroup.", "")}"),
                  ])));*/
            });
            return children;
          },
        ),
        GestureDetector(
          child: Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: Icon(mode == ProgressDisplayMode.DetailedCard
                  ? Icons.grid_on
                  : Icons.list)),
          onTap: _onChangeMode,
        ),
      ],
      backgroundColor: Theme.of(context).cardColor,
      flexibleSpace: FlexibleSpaceBar(
        title: Text("Victory points: ${getVictoryPoints()}",
            style: TextStyle(fontSize: 15.0)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget body;
    switch (mode) {
      case ProgressDisplayMode.Card:
        body = _getCardGrid(context);
        break;
      case ProgressDisplayMode.DetailedCard:
        body = _getDetailedCardList();
        break;
    }
    return CustomScrollView(slivers: [getSliverBar(), body]);
  }
}
