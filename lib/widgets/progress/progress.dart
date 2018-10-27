import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import 'package:mega_civ_rules/models/data/civilizationadvance.dart';
import 'package:mega_civ_rules/services/civilizationAdvanceService.dart';
import 'package:mega_civ_rules/services/imageMemoization.dart';
import 'package:mega_civ_rules/widgets/progress/civilizationAdvanceCard.dart';
import 'package:mega_civ_rules/widgets/CheckboxView/checkboxView.dart';
import 'package:mega_civ_rules/models/viewmodels/ProgressViewModel.dart';

enum ProgressDisplayMode { DetailedCard, Card }

class Progress extends StatefulWidget {
  Progress({Key key, @required this.searchString}) : super(key: key);
  final String searchString;

  @override
  ProgressState createState() => new ProgressState();
}

class ProgressState extends State<Progress>
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
        advancesToRender = viewModel.getAdvancesToRender(widget.searchString);
      });
    });
    CivilizationAdvanceService.get().then((advances) {
      this.setState(() {
        viewModel.setAdvances(advances);
        advancesToRender = viewModel.getAdvancesToRender(widget.searchString);
      });
    });
  }

  void _onTapAddRemoveAdvance(CivilizationAdvance advance, bool add) {
    this.setState(() {
      CivilizationAdvanceService.setAcquired(
          viewModel.addRemoveAcquiered(advance.id, add));
      advancesToRender = viewModel.getAdvancesToRender(widget.searchString);
    });
  }

  void reset() {
    setState(() {
      CivilizationAdvanceService.setAcquired(List());
      viewModel.setAcquired(List());
      advancesToRender = viewModel.getAdvancesToRender(widget.searchString);
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
      delegate: SliverChildBuilderDelegate((context, pos) {
        bool isAcquired = viewModel.isAcquired(advancesToRender[pos]);
        CivilizationAdvance advance = advancesToRender[pos];
        int reducedCost = viewModel.getReducedCost(advance);
        return Container(
            padding: EdgeInsets.all(5.0),
            color: isAcquired
                ? Theme.of(context).primaryColor
                : Theme.of(context).cardColor,
            child: Stack(fit: StackFit.expand, children: [
              GestureDetector(
                child: Container(
                    child: FadeInImage(
                        placeholder: MemoryImage(kTransparentImage),
                        image: MemoryImage(
                            ImageMemoization.instance.getImage(advance.id)))),
                onTap: () => _showModal(advance),
              ),
              Positioned(
                left: 0.0,
                bottom: 0.0,
                child: Chip(
                  backgroundColor: reducedCost == advance.cost
                      ? Theme.of(context).disabledColor
                      : Theme.of(context).textSelectionColor,
                  label: Text("$reducedCost"),
                ),
              ),
              Positioned(
                right: 0.0,
                bottom: 0.0,
                child: new FloatingActionButton(
                  mini: true,
                  child:
                      Icon(isAcquired ? Icons.remove_circle : Icons.add_circle),
                  backgroundColor: isAcquired
                      ? Theme.of(context).buttonColor
                      : Theme.of(context).errorColor,
                  onPressed: () {
                    _onTapAddRemoveAdvance(advance, !isAcquired);
                  },
                ),
              ),
            ]));
      }, childCount: advancesToRender.length),
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
      isAcquired: viewModel.isAcquired(advance),
      advance: advance,
      cost: viewModel.getReducedCost(advance),
      onTapAddRemove: _onTapAddRemoveAdvance,
      onTapShowCard: _showModal,
    );
  }

  void _onChangeCostSlider(double value) {
    setState(() {
      viewModel.setCostFilter(value);
      advancesToRender = viewModel.getAdvancesToRender(widget.searchString);
    });
  }

  Widget getSliverBar(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    Theme theme = Theme(
      data: themeData,
      child: SliverAppBar(
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
                      advancesToRender =
                          viewModel.getAdvancesToRender(widget.searchString);
                    });
                  },
                  icon: Icon(viewModel.getFilterCostAscending()
                      ? Icons.arrow_downward
                      : Icons.arrow_upward),
                  label: Text("${viewModel.getCostFilterValue().toInt()}")),
              Slider(
                label: "Price",
                activeColor: themeData.accentColor,
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
                                  advancesToRender = viewModel
                                      .getAdvancesToRender(widget.searchString);
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
                          viewModel.setFilterByAcquired(value);
                          advancesToRender = viewModel
                              .getAdvancesToRender(widget.searchString);
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
                          viewModel.setFilterByNotAcquired(value);
                          advancesToRender = viewModel
                              .getAdvancesToRender(widget.searchString);
                        });
                      },
                      key: "not_acquired",
                      title: "Not acquired",
                      value: viewModel.getFilterByNotAquiered()),
                )));
                children.add(PopupMenuItem(
                  enabled: false,
                  child: Divider(height: 0.0),
                ));
                children.add(PopupMenuItem(
                    child: Center(
                        child: RaisedButton(
                  onPressed: () => _neverSatisfied(),
                  child: const Text("Reset"),
                ))));
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
          // backgroundColor: Theme.of(context).cardColor,
          flexibleSpace: null),
    );
    return theme;
  }

  void _neverSatisfied() {
    showDialog<Null>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Reset all acquired?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to reset all acquired advances?'),
                Text('This action can not be reverted.'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Yes'),
              onPressed: () {
                reset();
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('No'),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget body;
    if (!CivilizationAdvanceService.loaded) {
      return new Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          new CircularProgressIndicator(),
          new Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: new Text("Loading advances")),
        ],
      );
    }
    switch (mode) {
      case ProgressDisplayMode.Card:
        body = _getCardGrid(context);
        break;
      case ProgressDisplayMode.DetailedCard:
        body = _getDetailedCardList();
        break;
    }
    return CustomScrollView(slivers: [getSliverBar(context), body]);
  }
}
