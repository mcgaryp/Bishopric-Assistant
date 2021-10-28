import 'package:models/models/account.dart';

///
/// mock_account.dart
/// bishopric-assistant
///
/// Created by Po on 9/28/21
/// Copyright 2021 porter. All rights reserved.
///

class MockAccount {
  static String mockFirst = "Mock";
  static String mockLast = "Test";
  static String mockEmail = "member@mock.com";
  static String mockPhone = "1234567890";
  static String mockPassword = "mockPassw0rd!";
  static String mockUsername = "member@mock.com";
  static AccountID mockId = AccountID("Mock Account ID");
  static Name mockName = Name(first: mockFirst, last: mockLast);
  static Contact mockContact = Contact(email: mockEmail, phone: mockPhone);
  static Credentials mockCredentials =
      Credentials(password: mockPassword, username: mockUsername);

  late Account account;

  MockAccount({
    AccountID? id,
    Name? name,
    Contact? contact,
    Credentials? credentials,
  }) {
    account = Account(
      id: id ?? mockId,
      name: name ?? mockName,
      contact: contact ?? mockContact,
      credentials: credentials ?? mockCredentials,
    );
  }
}
