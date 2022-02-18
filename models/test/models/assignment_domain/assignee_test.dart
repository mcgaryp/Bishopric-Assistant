import 'package:flutter_test/flutter_test.dart';
import 'package:models/models/assignment.dart';

import '../../mocks/assignment/mock_assignee.dart';

///
/// assignee_test.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 1/19/22
/// Copyright 2022 Porter McGary. All rights reserved.
///

class AssigneeTest {
  static givenMapReturnValidMap() {
    Assignee assignee = MockAssignee().assignee;
    Map<String, dynamic> map = assignee.toMap;
    expect(Assignee.fromMap(map) == assignee, true);
  }

  static comparisonTests() {
    Assignee assignee = MockAssignee().assignee;
    Assignee secondAssignee = MockAssignee().assignee;
    expect(assignee == secondAssignee, true);
    expect(secondAssignee == assignee, true);
    expect(assignee.sameValueAs(secondAssignee), true);
    expect(assignee != "Not Assignee", true);
    expect(assignee == "Not Assignee", false);
    expect("Not Assignee" == assignee, false);
  }
}

runAssigneeTests() {
  group("Assignee Tests", () {
    test("Mapping", AssigneeTest.givenMapReturnValidMap);
    test("Comparison Testing", AssigneeTest.comparisonTests);
  });
}
