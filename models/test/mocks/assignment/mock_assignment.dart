import 'package:models/models/account.dart';
import 'package:models/models/assignment.dart';
import 'package:models/models/organization.dart';

import '../account/mock_contact.dart';
import '../account/mock_name.dart';
import '../organization/mock_authorization.dart';
import '../organization/mock_member.dart';
import '../organization/mock_organization.dart';
import 'mock_assignee.dart';
import 'mock_note.dart';

///
/// assignment_mock.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 1/19/22
/// Copyright 2022 Porter McGary. All rights reserved.
///

class MockAssignment {
  static final Contact mockContact = MockContact().contact;
  static final Name mockName = MockName().name;
  static final AssignmentID mockID = MockAssignmentID().id;
  static final MemberID mockMemberID = MockMemberID().id;
  static final Authorization mockAuthorization = MockAuthorization().authorization;
  static final DateTime mockDueDate = DateTime.now();

  late final Assignment assignment;

  MockAssignment({
    AssignmentID? id,
    Creator? creator,
    bool isArchived = false,
    Assignee? assignee,
    bool isCompleted = false,
    Note? note,
    String title = "New Assignment",
    DateTime? dueDate,
    OrganizationID? organizationID,
  }) {
    assignment = Assignment(
      id: id ?? mockID,
      creator: creator ?? MockCreator().creator,
      isArchived: isArchived,
      assignee: assignee ?? MockAssignee().assignee,
      isCompleted: isCompleted,
      note: note ?? MockNote().note,
      title: title,
      dueDate: dueDate ?? mockDueDate,
      orgID: organizationID ??
          MockOrganization(id: MockOrganizationID().id).organization.id,
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

class MockCreator {
  late final Creator creator;

  MockCreator(
      {Name? name,
      Authorization? authorization,
      Contact? contact,
      MemberID? memberID}) {
    creator = Creator(
      name: name ?? MockName().name,
      authorization: authorization ?? MockAuthorization().authorization,
      contact: contact ?? MockContact().contact,
      id: memberID ?? MockMemberID().id,
    );
  }
}
