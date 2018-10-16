import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import 'package:mega_civ_rules/models/data/civilizationadvance.dart';
import 'package:mega_civ_rules/services/civilizationAdvanceService.dart';
import 'package:mega_civ_rules/services/imageMemoization.dart';
import 'package:mega_civ_rules/widgets/progress/civilizationAdvanceCard.dart';
import 'package:mega_civ_rules/models/viewmodels/civilizationAdvanceViewModel.dart';
import 'package:mega_civ_rules/widgets/CheckboxView/checkboxView.dart';
import 'package:mega_civ_rules/models/viewmodels/ProgressViewModel.dart';

enum ProgressDisplayMode { DetailedCard, Card }

class Progress extends StatefulWidget {
  Progress({Key key}) : super(key: key);

  @override
  _ProgressState createState() => new _ProgressState();
}

class _ProgressState extends State<Progress>
    with AutomaticKeepAliveClientMixin<Progress> {
  bool get wantKeepAlive => true;
  ProgressDisplayMode mode = ProgressDisplayMode.Card;
  ProgressViewModel viewModel = ProgressViewModel();
  List<CivilizationAdvance> advancesToRender = [];

  @override
  void initState() {
    super.initState();
    CivilizationAdvanceService.getAcquired().then((acquired) {
      this.setState(() {
        viewModel.setAcquired(acquired);
        advancesToRender = viewModel.getAdvancesToRender();
      });
    });
    CivilizationAdvanceService.get().then((advances) {
      this.setState(() {
        viewModel.setAdvances(advances);
        advancesToRender = viewModel.getAdvancesToRender();
      });
    });
  }

  void _onTapAddRemoveAdvance(CivilizationAdvance advance, bool add) {
    this.setState(() {
      CivilizationAdvanceService.setAcquired(
          viewModel.addRemoveAcquiered(advance.id, add));
      advancesToRender = viewModel.getAdvancesToRender();
    });
  }

  void _showModal(CivilizationAdvance a) {
    var data = ImageMemoization.instance.getImage(a.id);
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext modalContext) {
          return Container(
              child: Padding(
                  padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: Image.memory(
                    data,
                  )));
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
        mainAxisSpacing: 5.0,
        crossAxisSpacing: 5.0,
      ),
      delegate: SliverChildBuilderDelegate(
          (context, pos) => Container(
              padding: EdgeInsets.all(5.0),
              color: viewModel.isAcquiered(advancesToRender[pos])
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).cardColor,
              child: Stack(fit: StackFit.expand, children: [
                GestureDetector(
                  child: Container(
                      child: FadeInImage(
                          placeholder: MemoryImage(kTransparentImage),
                          image: MemoryImage(ImageMemoization.instance
                              .getImage(advancesToRender[pos].id)))),
                  onTap: () => _showModal(advancesToRender[pos]),
                ),
                Positioned(
                  right: 0.0,
                  bottom: 0.0,
                  child: new FloatingActionButton(
                    mini: true,
                    child: Icon(viewModel.isAcquiered(advancesToRender[pos])
                        ? Icons.remove_circle
                        : Icons.add_circle),
                    backgroundColor:
                        viewModel.isAcquiered(advancesToRender[pos])
                            ? Theme.of(context).buttonColor
                            : Theme.of(context).errorColor,
                    onPressed: () {
                      _onTapAddRemoveAdvance(advancesToRender[pos],
                          !viewModel.isAcquiered(advancesToRender[pos]));
                    },
                  ),
                ),
              ])),
          childCount: advancesToRender.length),
    );
  }

  Widget _getDetailedCardList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, pos) => _buildDetailedCardRow(context, advancesToRender[pos]),
        childCount: advancesToRender.length,
      ),
    );
  }

  Widget _buildDetailedCardRow(
      BuildContext context, CivilizationAdvance advance) {
    return new CivilizationAdvanceCard(
      viewModel: new CivilizationAdvanceViewModel(
          allAdvances: viewModel.getAllAdvancesMap(),
          advance: advance,
          acquired: viewModel.getAcquired()),
      onTapAddRemove: _onTapAddRemoveAdvance,
      onTapShowCard: _showModal,
    );
  }

  void _onChangeCostSlider(double value) {
    setState(() {
      viewModel.setCostFilter(value);
      advancesToRender = viewModel.getAdvancesToRender();
    });
  }

  Widget getSliverBar() {
    return SliverAppBar(
        floating: true,
        expandedHeight: 40.0,
        leading: Row(children: [
          Padding(
            child: Icon(Icons.stars),
            padding: EdgeInsets.only(left: 5.0),
          ),
          Padding(
            child: Text("${viewModel.getVictoryPoints()}",
                style: TextStyle(fontSize: 15.0)),
            padding: EdgeInsets.only(left: 5.0),
          )
        ]),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          Row(children: [
            RaisedButton.icon(
                onPressed: () {
                  setState(() {
                    viewModel.setFilterCostAscneding(
                        !viewModel.getFilterCostAscending());
                    advancesToRender = viewModel.getAdvancesToRender();
                  });
                },
                icon: Icon(viewModel.getFilterCostAscending()
                    ? Icons.arrow_downward
                    : Icons.arrow_upward),
                label: Text("${viewModel.getCostFilterValue().toInt()}")),
            Slider(
              value: viewModel.getCostFilterValue(),
              max: 290.0,
              min: 50.0,
              onChanged: _onChangeCostSlider,
            )
          ]),
          PopupMenuButton<String>(
            child: Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: Icon(Icons.filter_list)),
            itemBuilder: (BuildContext context) {
              List<PopupMenuEntry<String>> children = [];
              viewModel.getGroupFilter().forEach((group, val) {
                children.add(PopupMenuItem(
                    child: CheckboxView(
                        item: CheckBoxItem<CivilizationAdvanceGroup>(
                            onChange: (dynamic key, value) {
                              setState(() {
                                viewModel.setGroupFilter(key, value);
                                viewModel.filterAdvances();
                                advancesToRender =
                                    viewModel.getAdvancesToRender();
                              });
                            },
                            key: group,
                            title: viewModel.groupToString(group),
                            value: viewModel.getGroupFilterValue(group)))));
              });
              children.add(PopupMenuItem(
                enabled: false,
                child: Divider(),
              ));
              children.add(PopupMenuItem(
                  child: CheckboxView(
                item: CheckBoxItem<String>(
                    onChange: (dynamic key, value) {
                      setState(() {
                        viewModel.setFilterByAcquiered(value);
                        advancesToRender = viewModel.getAdvancesToRender();
                      });
                    },
                    key: "acquired",
                    title: "Acquired",
                    value: viewModel.getFilterByAcquiered()),
              )));
              children.add(PopupMenuItem(
                  child: CheckboxView(
                item: CheckBoxItem<String>(
                    onChange: (dynamic key, value) {
                      setState(() {
                        viewModel.setFilterByNotAcquiered(value);
                        advancesToRender = viewModel.getAdvancesToRender();
                      });
                    },
                    key: "not_acquired",
                    title: "Not acquired",
                    value: viewModel.getFilterByNotAquiered()),
              )));
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
        flexibleSpace: null);
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
