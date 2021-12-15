import 'package:models/models/account.dart';
import 'package:models/models/organization.dart';

///
/// mock_member.dart
/// bishopric-assistant
///
/// Created by Po on 9/28/21
/// Copyright 2021 porter. All rights reserved.
///

class MockMember {
  static MemberID mockId = MemberID("Mock Member ID");
  static String mockFirst = "Mock";
  static String mockLast = "Test";
  static String mockEmail = "member@mock.com";
  static String mockPhone = "1234567890";
  static Role mockRole = Role(Permissions.creator, anonymous: "Creator");
  static Contact mockContact = Contact(email: mockEmail, phone: mockPhone);
  static Name mockName = Name(first: mockFirst, last: mockLast);

  late Member member;

  MockMember({
    MemberID? id,
    String? first,
    OrganizationID? organizationID,
    Contact? contact,
    Name? name,
    Role? role,
  }) {
    member = Member(
        id: id ?? mockId,
        role: role ?? mockRole,
        contact: contact ?? mockContact,
        name: name ?? mockName);
  }
}
