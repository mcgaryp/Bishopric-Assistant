import 'package:models/models/user.dart';

///
/// mock_generic_user.dart
/// bishopric-assistant
///
/// Created by porter on 9/27/21
/// Copyright 2021 porter. All rights reserved.
///

class MockGenericUser {
  static UserID mockId = UserID("mock");
  static String mockFirst = "Mr. Mock";
  static String mockLast = "IsMocking";
  static String mockUsername = "user@mock.com";
  static String mockPassword = "mockPassw0rd!";

  late GenericUser user;

  MockGenericUser(
      {UserID? id,
      String? first,
      String? last,
      String? username,
      String? password}) {
    user = GenericUser(
        id: id ?? mockId,
        firstName: first ?? mockFirst,
        lastName: last ?? mockLast,
        username: username ?? mockUsername,
        password: password ?? mockPassword);
  }
}
