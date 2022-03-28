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

  Member get mockMember => Member(
        name: _mockName,
        contact: _mockContact,
        role: Role(
            name: "Fake Role",
            authorization: Authorization(rank: 0, name: 'Some Authorization')),
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

  Creator get _mockCreator => Creator(
        contact: _mockContact,
        name: _mockName,
        id: MemberID("Fake Member ID"),
        authorization: Authorization(rank: 0, name: 'Creator'),
      );

  Assignee get _mockAssignee => Assignee(
        contact: _mockContact,
        name: _mockName,
        id: MemberID("Fake Member ID"),
        authorization: Authorization(rank: 0, name: 'Creator')
      );

  Note get _mockNote => Note(
        content: "Some note content for the greater good! You have no idea how "
            "awesome it is. Hey guess what! i know a knock knock joke and you "
            "should totally think about the answer because i said so haha\n\n"
            "Here is me testing what a new line character does."
            "That one was a tab character. There are so many awesome things "
            "that i never know what i should put next in my text Hey guess what "
            "i found out that my dead cat died.",
        authorization: Authorization(rank: 0, name: 'Creator'),
      );

  Assignment get mockAssignment => Assignment(
        id: AssignmentID("Fake Assignment ID"),
        creator: _mockCreator,
        isArchived: false,
        assignee: _mockAssignee,
        isCompleted: false,
        note: _mockNote,
        title: "Fake Assignment",
        dueDate: DateTime.now(),
        orgID: OrganizationID("Fake Organization ID"),
      );
}
