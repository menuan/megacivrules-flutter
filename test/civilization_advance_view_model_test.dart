/*import 'package:flutter_test/flutter_test.dart';
import 'package:mega_civ_rules/models/data/civilizationadvance.dart';
import 'package:mega_civ_rules/models/viewmodels/civilizationAdvanceViewModel.dart';

void main() {
  test('CivilizationAdvance deserialization', () {
    var advance = CivilizationAdvance(
        attributes: [],
        cost: 100,
        id: "test1",
        image: "",
        name: "test",
        victoryPoints: 10,
        groups: [CivilizationAdvanceGroup.arts],
        colorCredits: [],
        reduceCosts: [
          CivilizationAdvanceReducedCost(reduced: 10, id: "test2")
        ]);
    var advance2 = CivilizationAdvance(
        attributes: [],
        cost: 100,
        id: "test2",
        image: "",
        name: "test2",
        victoryPoints: 40,
        groups: [CivilizationAdvanceGroup.civic],
        colorCredits: [
          ColorCredit(group: CivilizationAdvanceGroup.arts, value: 5)
        ],
        reduceCosts: [
          CivilizationAdvanceReducedCost(reduced: 20, id: "test1")
        ]);
    var advance3 = CivilizationAdvance(
        attributes: [],
        cost: 100,
        id: "test3",
        image: "",
        name: "test3",
        victoryPoints: 20,
        groups: [CivilizationAdvanceGroup.religion],
        colorCredits: [],
        reduceCosts: [
          CivilizationAdvanceReducedCost(reduced: 20, id: "test1")
        ]);
    var allAdvances = {
      advance.id: advance,
      advance2.id: advance2,
      advance3.id: advance3
    };
    var viewModel = CivilizationAdvanceViewModel(
        acquired: ["test1", "test2"],
        advance: advance,
        allAdvances: allAdvances);
    expect(viewModel.calculateReducedCost(), 75);

    viewModel = CivilizationAdvanceViewModel(
        acquired: ["test1"], advance: advance, allAdvances: allAdvances);
    expect(viewModel.calculateReducedCost(), 100);
  });
}
*/
