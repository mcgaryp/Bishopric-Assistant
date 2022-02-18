import 'package:models/models/account.dart';
import 'package:models/models/organization.dart';

import '../account/mock_contact.dart';
import '../account/mock_name.dart';
import 'mock_role.dart';

///
/// mock_member.dart
/// bishopric-assistant
///
/// Created by Po on 9/28/21
/// Copyright 2021 porter. All rights reserved.
///

class MockMember {
  static Role mockRole = MockRole().role;
  static Contact mockContact = MockContact().contact;
  static Name mockName = MockName().name;

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
        id: id,
        role: role ?? mockRole,
        contact: contact ?? mockContact,
        name: name ?? mockName);
  }
}

class MockMemberID {
  static String mockID = "Mock account ID";
  late MemberID id;

  MockMemberID({String? id}) {
    this.id = MemberID(id ?? mockID);
  }
}
