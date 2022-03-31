import 'package:models/models/account.dart';
import 'package:models/models/assignment.dart';
import 'package:models/models/organization.dart';

///
/// mocks.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 2/3/22
/// Copyright 2022 Porter McGary. All rights reserved.
///

class Mocks {
  Name get _mockName => Name(first: "Unauthenticated", last: "Account");

  Contact get _mockContact => Contact(
        email: "fake@email.com",
        phone: "(123) 456-7890",
      );

  Credentials get _mockCredentials => Credentials(
        username: "unauthenticated",
        password: "none",
      );

  Role get _mockRole => Role(
        name: "Fake Role",
        authorization: Authorization(rank: 0, name: 'Some Authorization'),
      );

  Member get mockMember => Member(
        name: _mockName,
        contact: _mockContact,
        role: _mockRole,
        id: MemberID("Fake ID"),
      );

  Member get _mockMember2 => Member(
        name: _mockName,
        contact: _mockContact,
        role: Role(
            name: "Fake Role",
            authorization: Authorization(rank: 0, name: 'Some Authorization')),
        id: MemberID("Fake Member ID"),
      );

  Organization get mockOrganization => Organization(
        creator: _mockMember2,
        name: "Fake Organization",
        id: OrganizationID("Fake ID"),
      );

  Account get mockAccount => Account(
        name: _mockName,
        contact: _mockContact,
        credentials: _mockCredentials,
      );

  @Deprecated("Not in use")
  Assignee get mockAssignee => Assignee(
      contact: _mockContact,
      name: _mockName,
      id: MemberID("Fake Member ID"),
      authorization: Authorization(rank: 0, name: 'Creator'));

  Assignment get mockAssignment => Assignment(
        id: AssignmentID("Fake Assignment ID"),
        creator: _mockRole,
        isArchived: false,
        assignee: _mockRole,
        isCompleted: false,
        note: "This is some note content",
        title: "Fake Assignment",
        dueDate: DateTime.now(),
        orgID: OrganizationID("Fake Organization ID"),
        editable: false,
        viewers: [],
        reassignable: true,
      );
}
