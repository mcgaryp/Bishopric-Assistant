import 'package:models/models/role.dart';
import 'package:models/models/user.dart';

///
/// mock_member_user.dart
/// bishopric-assistant
///
/// Created by porter on 9/28/21
/// Copyright 2021 porter. All rights reserved.
///

class MockMemberUser {
  static UserID mockId = UserID("mock");
  static String mockFirst = "Mock";
  static String mockLast = "Test";
  static String mockEmail = "member@mock.com";
  static String mockPhone = "1234567890";
  static Role mockRole = Role(
      id: RoleID("mock"),
      name: "Mock Role",
      securityClearance: SecurityClearance.level5);

  late MemberUser user;

  MockMemberUser({
    UserID? id,
    String? first,
    String? last,
    String? phone,
    String? email,
    Role? role,
  }) {
    user = MemberUser(
        id: id ?? mockId,
        firstName: first ?? mockFirst,
        lastName: last ?? mockLast,
        phone: phone ?? mockPhone,
        email: email ?? mockEmail,
        role: role ?? mockRole);
  }
}
