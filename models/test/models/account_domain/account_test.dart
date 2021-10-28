import 'package:flutter_test/flutter_test.dart';
import 'package:models/models/account.dart';

import '../../mocks/account/mock_account.dart';

///
/// account_test.dart
/// bishopric-assistant
///
/// Created by Po on 9/28/21
/// Copyright 2021 Po. All rights reserved.
///

class AccountTest {
  static void shouldReturnValidID() {
    AccountID id = AccountID("Mock Account ID");
    AccountID result = MockAccount().account.id;
    expect(result, id);
  }

  static void shouldReturnValidName() {
    Name name = Name(first: "Mock", last: "Test");
    Name result = MockAccount(name: name).account.name;
    expect(result, name);
  }

  static void shouldReturnValidContact() {
    Contact contact = Contact(email: "mock@me.com", phone: "1234567890");
    Contact result = MockAccount(contact: contact).account.contact;
    expect(result, contact);
  }

  static void shouldReturnValidCredentials() {
    Credentials credentials =
        Credentials(password: "password", username: "username");
    Credentials results =
        MockAccount(credentials: credentials).account.credentials;
    expect(results, credentials);
  }

  static void shouldReturnTrueWhenGivenSameEntity() {
    AccountID id = AccountID("same");
    Account account = MockAccount(id: id).account;
    bool results = account.sameIdentityAs(account);
    expect(results, true);
  }

  static void shouldReturnFalseWhenGivenNotSameEntity() {
    AccountID leftId = AccountID("left");
    AccountID rightId = AccountID("right");
    Account leftAccount = MockAccount(id: leftId).account;
    Account rightAccount = MockAccount(id: rightId).account;
    bool results = leftAccount.sameIdentityAs(rightAccount);
    expect(results, false);
  }

  static void shouldReturnTrueWhenGivenSameEntityEquivalence() {
    AccountID id = AccountID("same");
    Account account = MockAccount(id: id).account;
    bool results = account == account;
    expect(results, true);
  }

  static void shouldReturnFalseWhenGivenNotSameEntityEquivalence() {
    AccountID leftId = AccountID("left");
    AccountID rightId = AccountID("right");
    Account leftAccount = MockAccount(id: leftId).account;
    Account rightAccount = MockAccount(id: rightId).account;
    bool results = leftAccount == rightAccount;
    expect(results, false);
  }
}

runAccountTests() {
  group("Account", () {
    test("should return valid ID", AccountTest.shouldReturnValidID);
    test("should return valid Name", AccountTest.shouldReturnValidName);
    test("should return valid Contact", AccountTest.shouldReturnValidContact);
    test("should return valid Credentials",
        AccountTest.shouldReturnValidCredentials);
    // test("should return valid role", AccountTest.shouldReturnValidRole);
    test("should return true with same entity",
        AccountTest.shouldReturnFalseWhenGivenNotSameEntity);
    test("should return false with same entity",
        AccountTest.shouldReturnFalseWhenGivenNotSameEntity);
    test("should return true with equivalence operator",
        AccountTest.shouldReturnTrueWhenGivenSameEntityEquivalence);
    test("should return false with equivalence operator",
        AccountTest.shouldReturnFalseWhenGivenNotSameEntityEquivalence);
  });
}
