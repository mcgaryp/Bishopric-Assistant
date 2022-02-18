import 'package:flutter_test/flutter_test.dart';
import 'package:models/models/account.dart';
import 'package:models/shared/exceptions/exceptions.dart';
import 'package:models/shared/test.dart';

import '../../mocks/account/mock_account.dart';

///
/// account_test.dart
/// bishopric-assistant
///
/// Created by Po on 9/28/21
/// Copyright 2021 Po. All rights reserved.
///

class AccountTest implements Test {
  static void verifyID() {
    MockAccount(id: MockAccountID().id).account.id;
    try {
      MockAccount().account.id;
      Test.fallthrough(notes: "Does not notify of null id");
    } catch (error) {
      expect(error.toString(),
          IdDoesNotExistError(forObject: "Account").toString());
    }
  }

  static void verifySameIdentityAs() {
    AccountID id = MockAccountID(id: "same").id;
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

  static void verifyMapping() {
    Account accountWithoutID = MockAccount().account;
    Map<String, dynamic> mapWithoutID = accountWithoutID.toMap;
    Account account = Account.fromMap(mapWithoutID);
    expect(account == accountWithoutID, true);

    Account accountWithID = MockAccount(id: MockAccountID().id).account;
    Map<String, dynamic> mapWithID = accountWithID.toMap;
    Account secondAccount = Account.fromMap(mapWithID);
    expect(accountWithID == secondAccount, true);

    expect(account != secondAccount, true);
  }
}

runAccountTests() {
  group("Account", () {
    test("should return valid ID", AccountTest.verifyID);
    test("verify sameIdentityAs", AccountTest.verifySameIdentityAs);
    test("should return false with same entity",
        AccountTest.shouldReturnFalseWhenGivenNotSameEntity);
    test("should return true with equivalence operator",
        AccountTest.shouldReturnTrueWhenGivenSameEntityEquivalence);
    test("should return false with equivalence operator",
        AccountTest.shouldReturnFalseWhenGivenNotSameEntityEquivalence);
    test("verify Mapping", AccountTest.verifyMapping);
  });
}
