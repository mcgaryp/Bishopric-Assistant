import 'package:models/models/member.dart';

///
/// mock_member.dart
/// bishopric-assistant
///
/// Created by porter on 9/28/21
/// Copyright 2021 porter. All rights reserved.
///

class MockMember {
  static MemberID mockId = MemberID("Mock Member ID");
  static String mockFirst = "Mock";
  static String mockLast = "Test";
  static String mockEmail = "member@mock.com";
  static String mockPhone = "1234567890";
  static Role mockRole = Role(Permissions.creator, anonymous: "Creator");
  static OrganizationID mockOrganizationID =
      OrganizationID("Mock Organization ID");
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
        organizationID: organizationID ?? mockOrganizationID,
        contact: contact ?? mockContact,
        name: name ?? mockName);
  }
}
