import 'package:flutter_test/flutter_test.dart';
import 'package:models/models/organization.dart';
import 'package:models/shared/exceptions/exceptions.dart';
import 'package:models/shared/test.dart';

import '../../mocks/account/mock_contact.dart';
import '../../mocks/account/mock_name.dart';
import '../../mocks/organization/mock_authorization.dart';
import '../../mocks/organization/mock_member.dart';
import '../../mocks/organization/mock_role.dart';

///
/// member_test.dart
/// bishopric-assistant
///
/// Created by Po on 9/23/21
/// Copyright 2021 Po. All rights reserved.
///

class MemberTest implements Test {
  static void verifyID() {
    MockMember(id: MockMemberID().id).member.id;

    try {
      MockMember().member.id;
      Test.fallthrough(notes: "Failed to notify of null id");
    } catch (error) {
      expect(error.toString(),
          IdDoesNotExistError(forObject: "Member").toString());
    }
  }

  // EQUIVALENCY
  static void verifyEquivalencyOperator() {
    Member member = MockMember().member;
    expect(member == member, true);
    expect(member == MockMember(id: MockMemberID().id).member, false);
    expect(member == MockMember().member, true);
    expect(member == MockMember(id: MockMemberID(id: "different").id).member,
        false);
    expect(
        member ==
            MockMember(
                    id: MockMemberID(id: "different").id,
                    contact: MockContact(phone: "12345678900").contact)
                .member,
        false);
    expect(
        member ==
            MockMember(
                    id: MockMemberID(id: "different").id,
                    name: MockName(first: "different").name)
                .member,
        false);
    expect(
        member ==
            MockMember(
                    id: MockMemberID(id: "different").id,
                    role: MockRole(authorization: MockAuthorization.Protected)
                        .role)
                .member,
        false);
  }

  // SAME ID AS
  static void verifySameIdentityAs() {
    Member member = MockMember().member;
    expect(member.sameIdentityAs(member), true);
    expect(
        member.sameIdentityAs(MockMember(id: MockMemberID().id).member), false);
    expect(member.sameIdentityAs(MockMember().member), true);
    expect(
        member.sameIdentityAs(
            MockMember(id: MockMemberID(id: "different").id).member),
        false);
    expect(
        member.sameIdentityAs(MockMember(
                id: MockMemberID(id: "different").id,
                contact: MockContact(phone: "12345678900").contact)
            .member),
        false);
    expect(
        member.sameIdentityAs(MockMember(
                id: MockMemberID(id: "different").id,
                name: MockName(first: "different").name)
            .member),
        false);
    expect(
        member.sameIdentityAs(MockMember(
                id: MockMemberID(id: "different").id,
                role: MockRole(authorization: MockAuthorization.Protected).role)
            .member),
        false);
  }

  static void verifyMapping() {
    Member memberWithoutID = MockMember().member;
    Map<String, dynamic> mapWithoutID = memberWithoutID.toMap;
    Member member = Member.fromMap(mapWithoutID);
    expect(member == memberWithoutID, true);

    Member memberWithID = MockMember(id: MockMemberID().id).member;
    Map<String, dynamic> mapWithID = memberWithID.toMap;
    Member newMember = Member.fromMap(mapWithID);
    expect(newMember == memberWithID, true);

    expect(newMember != member, true);
  }
}

runMemberTests() {
  group("Member Tests", () {
    test("verify id", MemberTest.verifyID);
    // TODO: Check test
    // test("verify mapping", MemberTest.verifyMapping);
    test("equivalency", MemberTest.verifyEquivalencyOperator);
    test("Same Identity as", MemberTest.verifySameIdentityAs);
  });
}
