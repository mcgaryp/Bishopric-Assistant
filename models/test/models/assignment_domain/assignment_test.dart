import 'package:flutter_test/flutter_test.dart';
import 'package:models/models/assignment.dart';
import 'package:models/models/organization.dart';
import 'package:models/shared/exceptions/exceptions.dart';
import 'package:models/shared/test.dart';

import '../../mocks/assignment/mock_assignee.dart';
import '../../mocks/assignment/mock_assignment.dart';
import '../../mocks/organization/mock_member.dart';

///
/// assignment_test.dart
/// bishopric-assistant
///
/// Created by Po on 9/23/21
/// Copyright 2021 Po. All rights reserved.
///

class AssignmentTest implements Test {
  static givenValidDueDateReturnValidDate() {
    // Date cannot be a past date.
    // we do not care about the time of day, hour, minute, second ...
    DateTime test = DateTime.now();
    Assignment assignment = MockAssignment(dueDate: test).assignment;
    expect(assignment.dueDate, test);

    test = test.add(Duration(days: 1));
    assignment = MockAssignment(dueDate: test).assignment;
    expect(assignment.dueDate, test);

    test = test.add(Duration(days: -2));
    expect(assignment.dueDate != test, true);
  }

  static givenValidTitleReturnValidTitle() {
    Assignment assignment = MockAssignment().assignment;
    String test = assignment.title;
    expect(assignment.title, test);

    test = "Hello world";
    expect(assignment.title == test, false);

    test = "";
    try {
      assignment = MockAssignment(title: test).assignment;
    } catch (e) {
      expect(EmptyStringError(forObject: "Assignment title").toString(),
          e.toString());
      return;
    }
    Test.fallthrough();
  }

  static givenValidIdReturnValidID() {
    Assignment assignment = MockAssignment().assignment;
    AssignmentID? id = assignment.id;
    expect(assignment.id, id);

    id = null;
    try {
      assignment = MockAssignment(id: id).assignment;
    } catch (e) {
      expect(IdDoesNotExistError(forObject: "Assignment").toString(),
          e.toString());
      return;
    }
    Test.fallthrough();
  }

  static givenValidMapReturnMap() {
    Assignment assignment = MockAssignment().assignment;
    Map<String, dynamic> map = assignment.toMap;
    expect(Assignment.fromMap(map) == assignment, true);
  }

  static comparisonTests() {
    Assignment assignment = MockAssignment().assignment;
    Assignment secondAssignment = MockAssignment().assignment;
    expect(assignment == secondAssignment, true);
    expect(secondAssignment == assignment, true);
    expect(assignment.sameIdentityAs(secondAssignment), true);
    expect(assignment != "Not Assignment", true);
    expect(assignment == "Not Assignment", false);
    expect("Not Assignment" == assignment, false);
  }

  static verifyIsArchivedAndIsCompleted() {
    bool isArchived = false;
    bool isCompleted = false;
    Assignment assignment =
        MockAssignment(isArchived: isArchived, isCompleted: isCompleted)
            .assignment;
    expect(assignment.isArchived, isArchived);
    expect(assignment.isCompleted, isCompleted);
    assignment.archive();
    expect(assignment.isArchived, true);
    expect(assignment.isNotArchived, false);
    assignment.markComplete();
    expect(assignment.isCompleted, true);
    expect(assignment.isNotCompleted, false);
    assignment.unArchive();
    expect(assignment.isArchived, false);
    expect(assignment.isNotArchived, true);
    assignment.markIncomplete();
    expect(assignment.isCompleted, false);
    expect(assignment.isNotCompleted, true);
  }

  // Check that isOverDue works correctly
  static verifyIsOverDue() {
    Assignment assignment = MockAssignment(dueDate: DateTime.now()).assignment;
    expect(assignment.isOverDue, true);

    assignment =
        MockAssignment(dueDate: DateTime.now().add(Duration(seconds: 1)))
            .assignment;
    expect(assignment.isOverDue, false);

    assignment =
        MockAssignment(dueDate: DateTime.now().subtract(Duration(seconds: 1)))
            .assignment;
    expect(assignment.isOverDue, true);
  }

  static final creator = Permissions.Creator;
  static final maintainer = Permissions.Maintainer;
  static final reporter = Permissions.Reporter;
  static final viewer = Permissions.Viewer;

  // Check that canView works properly
  static verifyCanView() {
    Assignment assignment =
        MockAssignment(assignee: MockAssignee(permissions: creator).assignee)
            .assignment;

    expect(assignment.canView(memberID: MockMemberID().id), true);
    expect(assignment.canView(memberID: MockMemberID(id: "Some other guys").id),
        false);

    expect(assignment.canView(permissions: creator), true);
    expect(assignment.canView(permissions: maintainer), false);
    expect(assignment.canView(permissions: reporter), false);
    expect(assignment.canView(permissions: viewer), false);

    assignment =
        MockAssignment(assignee: MockAssignee(permissions: maintainer).assignee)
            .assignment;
    expect(assignment.canView(permissions: creator), true);
    expect(assignment.canView(permissions: maintainer), true);
    expect(assignment.canView(permissions: reporter), false);
    expect(assignment.canView(permissions: viewer), false);

    assignment =
        MockAssignment(assignee: MockAssignee(permissions: reporter).assignee)
            .assignment;
    expect(assignment.canView(permissions: creator), true);
    expect(assignment.canView(permissions: maintainer), true);
    expect(assignment.canView(permissions: reporter), true);
    expect(assignment.canView(permissions: viewer), false);

    assignment =
        MockAssignment(assignee: MockAssignee(permissions: viewer).assignee)
            .assignment;
    expect(assignment.canView(permissions: creator), true);
    expect(assignment.canView(permissions: maintainer), true);
    expect(assignment.canView(permissions: reporter), true);
    expect(assignment.canView(permissions: viewer), true);
  }

  // Check that canArchive works properly
  static verifyCanArchive() {
    Assignment assignment =
        MockAssignment(assignee: MockAssignee(permissions: creator).assignee)
            .assignment;

    expect(assignment.canView(memberID: MockMemberID().id), true);
    expect(assignment.canView(memberID: MockMemberID(id: "Some other guys").id),
        false);

    expect(assignment.canArchive(permissions: creator), true);
    expect(assignment.canArchive(permissions: maintainer), false);
    expect(assignment.canArchive(permissions: reporter), false);
    expect(assignment.canArchive(permissions: viewer), false);

    assignment =
        MockAssignment(assignee: MockAssignee(permissions: maintainer).assignee)
            .assignment;
    expect(assignment.canArchive(permissions: creator), true);
    expect(assignment.canArchive(permissions: maintainer), true);
    expect(assignment.canArchive(permissions: reporter), false);
    expect(assignment.canArchive(permissions: viewer), false);

    assignment =
        MockAssignment(assignee: MockAssignee(permissions: reporter).assignee)
            .assignment;
    expect(assignment.canArchive(permissions: creator), true);
    expect(assignment.canArchive(permissions: maintainer), true);
    expect(assignment.canArchive(permissions: reporter), true);
    expect(assignment.canArchive(permissions: viewer), false);

    assignment =
        MockAssignment(assignee: MockAssignee(permissions: viewer).assignee)
            .assignment;
    expect(assignment.canArchive(permissions: creator), true);
    expect(assignment.canArchive(permissions: maintainer), true);
    expect(assignment.canArchive(permissions: reporter), true);
    expect(assignment.canArchive(permissions: viewer), true);
  }

  // Check that canComplete works properly
  static verifyCanComplete() {
    Assignment assignment =
        MockAssignment(assignee: MockAssignee(permissions: creator).assignee)
            .assignment;

    expect(assignment.canView(memberID: MockMemberID().id), true);
    expect(assignment.canView(memberID: MockMemberID(id: "Some other guys").id),
        false);

    expect(assignment.canComplete(permissions: creator), true);
    expect(assignment.canComplete(permissions: maintainer), true);
    expect(assignment.canComplete(permissions: reporter), false);
    expect(assignment.canComplete(permissions: viewer), false);

    assignment =
        MockAssignment(assignee: MockAssignee(permissions: maintainer).assignee)
            .assignment;
    expect(assignment.canComplete(permissions: creator), true);
    expect(assignment.canComplete(permissions: maintainer), true);
    expect(assignment.canComplete(permissions: reporter), false);
    expect(assignment.canComplete(permissions: viewer), false);

    assignment =
        MockAssignment(assignee: MockAssignee(permissions: reporter).assignee)
            .assignment;
    expect(assignment.canComplete(permissions: creator), true);
    expect(assignment.canComplete(permissions: maintainer), true);
    expect(assignment.canComplete(permissions: reporter), false);
    expect(assignment.canComplete(permissions: viewer), false);

    assignment =
        MockAssignment(assignee: MockAssignee(permissions: viewer).assignee)
            .assignment;
    expect(assignment.canComplete(permissions: creator), true);
    expect(assignment.canComplete(permissions: maintainer), true);
    expect(assignment.canComplete(permissions: reporter), false);
    expect(assignment.canComplete(permissions: viewer), false);
  }

  // Check that canEdit works properly
  static verifyCanEdit() {
    Assignment assignment =
        MockAssignment(assignee: MockAssignee(permissions: creator).assignee)
            .assignment;

    expect(assignment.canView(memberID: MockMemberID().id), true);
    expect(assignment.canView(memberID: MockMemberID(id: "Some other guys").id),
        false);

    expect(assignment.canEdit(permissions: creator), true);
    expect(assignment.canEdit(permissions: maintainer), true);
    expect(assignment.canEdit(permissions: reporter), false);
    expect(assignment.canEdit(permissions: viewer), false);

    assignment =
        MockAssignment(assignee: MockAssignee(permissions: maintainer).assignee)
            .assignment;
    expect(assignment.canEdit(permissions: creator), true);
    expect(assignment.canEdit(permissions: maintainer), true);
    expect(assignment.canEdit(permissions: reporter), false);
    expect(assignment.canEdit(permissions: viewer), false);

    assignment =
        MockAssignment(assignee: MockAssignee(permissions: reporter).assignee)
            .assignment;
    expect(assignment.canEdit(permissions: creator), true);
    expect(assignment.canEdit(permissions: maintainer), true);
    expect(assignment.canEdit(permissions: reporter), false);
    expect(assignment.canEdit(permissions: viewer), false);

    assignment =
        MockAssignment(assignee: MockAssignee(permissions: viewer).assignee)
            .assignment;
    expect(assignment.canEdit(permissions: creator), true);
    expect(assignment.canEdit(permissions: maintainer), true);
    expect(assignment.canEdit(permissions: reporter), false);
    expect(assignment.canEdit(permissions: viewer), false);
  }
}

runAssignmentTests() {
  group("Assignment Tests", () {
    test(
        "Validating Due Date", AssignmentTest.givenValidDueDateReturnValidDate);
    test("Validating Title", AssignmentTest.givenValidTitleReturnValidTitle);
    test("Mapping", AssignmentTest.givenValidMapReturnMap);
    test("Comparisons", AssignmentTest.comparisonTests);
    test("IsArchived and IsCompleted",
        AssignmentTest.verifyIsArchivedAndIsCompleted);
    test("Verify is over due", AssignmentTest.verifyIsOverDue);
    test("Verify Can Edit", AssignmentTest.verifyCanEdit);
    test("Verify Can Archive", AssignmentTest.verifyCanArchive);
    test("Verify Can View", AssignmentTest.verifyCanView);
    test("Verify Can Complete", AssignmentTest.verifyCanComplete);
  });
}
