import 'package:flutter_test/flutter_test.dart';
import 'package:models/models/assignment_domain/creator.dart';
import 'package:models/models/organization.dart';
import 'package:models/shared/test.dart';

import '../../mocks/assignment/mock_creator.dart';
import '../../mocks/organization/mock_member.dart';

///
/// creator_test.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 1/19/22
/// Copyright 2022 Porter McGary. All rights reserved.
///

class CreatorTest implements Test {
  static givenMapReturnValidMap() {
    Creator creator = MockCreator().creator;
    Map<String, dynamic> map = creator.toMap;
    expect(Creator.fromMap(map) == creator, true);
  }

  static comparisonTests() {
    Creator assignee = MockCreator().creator;
    Creator secondAssignee = MockCreator().creator;
    expect(assignee == secondAssignee, true);
    expect(secondAssignee == assignee, true);
    expect(assignee.sameValueAs(secondAssignee), true);
    expect(assignee != "Not Assignee", true);
    expect(assignee == "Not Assignee", false);
    expect("Not Assignee" == assignee, false);
  }

  // verify from member
  static verifyFromMemberConstructor() {
    Member member = MockMember(id: MockMemberID().id).member;
    Creator expected = Creator(
      name: member.name,
      contact: member.contact,
      authorization: member.role.authorization,
      id: member.id,
    );
    Creator creatorFromMember = Creator.fromMember(member);

    expect(creatorFromMember == expected, true);
  }
}

runCreatorTests() {
  group("Creator Tests", () {
    test("Mapping", CreatorTest.givenMapReturnValidMap);
    test("Comparisons", CreatorTest.comparisonTests);
    test("From Member constructor", CreatorTest.verifyFromMemberConstructor);
  });
}
