import 'package:models/models/assignment.dart';
import 'package:models/models/organization.dart';

import '../organization/mock_organization.dart';
import '../organization/mock_role.dart';

///
/// assignment_mock.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 1/19/22
/// Copyright 2022 Porter McGary. All rights reserved.
///

class MockAssignment {
  late final Assignment assignment;

  MockAssignment({
    AssignmentID? id,
    Role? creator,
    bool isArchived = false,
    Role? assignee,
    bool isCompleted = false,
    String note = "This is a note.",
    String title = "New Assignment",
    DateTime? dueDate,
    OrganizationID? organizationID,
    bool reassignable = true,
    bool editable = true,
  }) {
    assignment = Assignment(
      viewers: List.filled(3, MockRole().role),
      id: id ?? MockAssignmentID().id,
      creator: creator ?? MockRole().role,
      isArchived: isArchived,
      assignee: assignee ?? MockRole().role,
      isCompleted: isCompleted,
      note: note,
      title: title,
      dueDate: dueDate ?? DateTime.now(),
      orgID: organizationID ??
          MockOrganization(id: MockOrganizationID().id).organization.id,
      reassignable: reassignable,
      editable: editable,
    );
  }
}

class MockAssignmentID {
  static String mockID = "Mock assignment ID";
  late AssignmentID id;

  MockAssignmentID({String? id}) {
    this.id = AssignmentID(id ?? mockID);
  }
}
