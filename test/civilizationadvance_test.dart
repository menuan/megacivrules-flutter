import 'package:flutter_test/flutter_test.dart';
import 'package:mega_civ_rules/models/data/civilizationadvance.dart';

void main() {
  test('CivilizationAdvance deserialization', () {
    Map<String, dynamic> json = {
      "groups": ["science"]
    };
    var advance = CivilizationAdvance.fromJson(json);
    expect(advance.groups, [CivilizationAdvanceGroup.science]);

    json = {
      "groups": ["arts", "science"]
    };
    advance = CivilizationAdvance.fromJson(json);
    expect(advance.groups,
        [CivilizationAdvanceGroup.arts, CivilizationAdvanceGroup.science]);

    json = {
      "groups": ["civic"]
    };
    advance = CivilizationAdvance.fromJson(json);
    expect(advance.groups, [CivilizationAdvanceGroup.civic]);

    json = {
      "groups": ["crafts"]
    };
    advance = CivilizationAdvance.fromJson(json);
    expect(advance.groups, [CivilizationAdvanceGroup.crafts]);
  });
}
