import 'package:mega_civ_rules/models/data/civilizationadvance.dart';

class ProgressViewModel {
  ProgressViewModel();

  List<CivilizationAdvance> advances = List();
  List<CivilizationAdvance> filteredAdvances = List();
  List<String> acquired = List();
  Map<String, CivilizationAdvance> allAdvancesMap = Map();

  Map<CivilizationAdvanceGroup, bool> filter = {
    CivilizationAdvanceGroup.science: true,
    CivilizationAdvanceGroup.crafts: true,
    CivilizationAdvanceGroup.civic: true,
    CivilizationAdvanceGroup.arts: true,
    CivilizationAdvanceGroup.religion: true
  };

  bool filterByAcquiered = true;
  bool filterByNotAcquiered = true;
  double _costFilter = 290.0;

  bool isAcquiered(CivilizationAdvance a) {
    return this.acquired.contains(a.id);
  }

  List<CivilizationAdvance> getAdvancesToRender() {
    return filteredAdvances;
  }

  List<String> getAcquired() {
    return this.acquired;
  }

  int _advancesSort(CivilizationAdvance a, CivilizationAdvance b) {
    int sort = a.cost - b.cost;
    if (sort < 0) return -1;
    if (sort > 0) return 1;
    return sort;
  }

  Map<String, CivilizationAdvance> getAllAdvancesMap() {
    return this.allAdvancesMap;
  }

  void _sort() {
    filteredAdvances.sort(_advancesSort);
  }

  void setAdvances(List<CivilizationAdvance> advances) {
    this.advances = advances;
    this.filteredAdvances = advances;
    allAdvancesMap = Map.fromIterable(advances,
        key: (item) => item.id, value: (item) => item);
    _sort();
  }

  void setGroupFilter(CivilizationAdvanceGroup group, bool value) {
    filter[group] = value;
    filterAdvances();
  }

  void setAcquired(List<String> acquired) {
    this.acquired = acquired;
    filterAdvances();
  }

  bool getFilterByAcquiered() {
    return this.filterByAcquiered;
    filterAdvances();
  }

  bool getFilterByNotAquiered() {
    return this.filterByNotAcquiered;
  }

  Map<CivilizationAdvanceGroup, bool> getGroupFilter() {
    return this.filter;
  }

  String groupToString(CivilizationAdvanceGroup group) {
    return group.toString().replaceAll("CivilizationAdvanceGroup.", "");
  }

  bool getGroupFilterValue(CivilizationAdvanceGroup group) {
    return this.filter[group];
  }

  List<String> addRemoveAcquiered(String id, bool add) {
    if (add) {
      this.acquired.add(id);
    } else {
      this.acquired.remove(id);
    }
    return this.acquired;
  }

  void setCostFilter(double value) {
    _costFilter = value;
  }

  double getCostFilterValue() {
    return _costFilter;
  }

  String getVictoryPoints() {
    if (acquired.length > 0 && advances.length > 0) {
      return this
          .acquired
          .map((a) {
            var found = this
                .advances
                .firstWhere((ad) => ad.id == a, orElse: () => null);
            return found != null ? found.victoryPoints : 0;
          })
          .reduce((value, element) => value + element)
          .toString();
    }
    return "0";
  }

  void setFilterByAcquiered(bool val) {
    this.filterByAcquiered = val;
    filterAdvances();
  }

  void setFilterByNotAcquiered(bool val) {
    this.filterByNotAcquiered = val;
    filterAdvances();
  }

  void filterAdvances() {
    var activeFilter = this.filter.keys.where((key) => filter[key]);
    var filterByGroup = (groups) {
      for (var g in groups) {
        if (activeFilter.contains(g)) {
          return true;
        }
      }
      return false;
    };
    var filterByAcquiered = (id) {
      return this.acquired.contains(id);
    };
    var filterByNotAquieredFunction = (id) {
      return !this.acquired.contains(id);
    };
    this.filteredAdvances = this.advances.where((a) {
      // Filter by group
      var byGroup = filterByGroup(a.groups);
      if (byGroup) {
        bool shouldFilter = true;
        if (this.filterByAcquiered) {
          shouldFilter = filterByAcquiered(a.id);
        } else {
          shouldFilter = false;
        }
        if (this.filterByNotAcquiered) {
          shouldFilter = shouldFilter || filterByNotAquieredFunction(a.id);
        }
        return shouldFilter;
      }
      return false;
    }).toList();
  }
}
