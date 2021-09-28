import 'package:models/models/role.dart';
import 'package:models/models/user.dart';

///
/// mock_current_user.dart
/// bishopric-assistant
///
/// Created by porter on 9/28/21
/// Copyright 2021 porter. All rights reserved.
///

class MockCurrentUser {
  static UserID mockId = UserID("mock");
  static String mockFirst = "Mock";
  static String mockLast = "Test";
  static String mockEmail = "member@mock.com";
  static String mockPhone = "1234567890";
  static Role mockRole = Role(
      id: RoleID("mock"),
      name: "Mock Role",
      securityClearance: SecurityClearance.level5);
  static Privileges mockPrivileges = Privileges(true, true, true);
  static String mockPassword = "mockPassw0rd!";
  static String mockUsername = "member@mock.com";

  late CurrentUser user;

  MockCurrentUser({
    UserID? id,
    String? first,
    String? last,
    String? phone,
    String? email,
    String? password,
    String? username,
    Privileges? privileges,
    Role? role,
  }) {
    user = CurrentUser(
        id: id ?? mockId,
        firstName: first ?? mockFirst,
        lastName: last ?? mockLast,
        phone: phone ?? mockPhone,
        email: email ?? mockEmail,
        username: username ?? mockUsername,
        password: password ?? mockPassword,
        privileges: privileges ?? mockPrivileges,
        role: role ?? mockRole);
  }
}
