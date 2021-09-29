///
/// mock_unauthenticated_account.dart
/// bishopric-assistant
///
/// Created by porter on 9/27/21
/// Copyright 2021 porter. All rights reserved.
///

class MockUnauthenticatedAccount {
  static String mockFirst = "Mr. Mock";
  static String mockLast = "IsMocking";
  static String mockUsername = "user@mock.com";
  static String mockPassword = "mockPassw0rd!";

  // late UnauthenticatedAccount unauthenticatedAccount;

  MockGenericUser(
      {String? first, String? last, String? username, String? password}) {
    // unauthenticatedAccount = UnauthenticatedAccount(
    //     firstName: first ?? mockFirst,
    //     lastName: last ?? mockLast,
    //     username: username ?? mockUsername,
    //     password: password ?? mockPassword);
  }
}
