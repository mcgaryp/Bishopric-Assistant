import 'package:models/models/account.dart';

import 'mock_account.dart';

///
/// mock_account_repository.dart
/// bishopric-assistant
///
/// Created by Joshua Bee on 2/2/22
/// Copyright 2022 Joshua Bee. All rights reserved.
///

class MockAccountRepository implements AccountRepository {
  bool activateFlag = false;
  bool findFlag = false;
  bool findByEmailFlag = false;
  bool findByPhoneFlag = false;
  bool findByUsernameFlag = false;
  bool findStreamedFlag = false;
  bool insertFlag = false;
  bool loginFlag = false;
  bool logoutFlag = false;
  bool deactivateFlag = false;
  bool updateFlag = false;

  final Account account;
  final bool shouldFail;
  final bool _succeed;

  MockAccountRepository({
    Account? account,
    this.shouldFail = false,
  })  : this.account = account ?? MockAccount(id: MockAccountID().id).account,
        this._succeed = !shouldFail;

  @override
  Future<bool> activate(AccountID id) {
    activateFlag = true;
    return Future.value(_succeed);
  }

  @override
  Future<Account?> find(AccountID i) {
    findFlag = true;
    if (i == account.id) return Future.value(account);
    return Future.value(null);
  }

  @override
  Future<Account?> findByUsername(String username) {
    findByUsernameFlag = true;
    if (username == account.credentials.username) return Future.value(account);
    return Future.value(null);
  }

  @override
  Future<bool> insert(Account account) {
    insertFlag = true;
    return Future.value(_succeed);
  }

  @override
  Future<bool> login(AccountID id) {
    loginFlag = true;
    return Future.value(_succeed);
  }

  @override
  Future<bool> logout() {
    logoutFlag = true;
    return Future.value(_succeed);
  }

  @override
  Future<bool> update(Account m) {
    updateFlag = true;
    return Future.value(_succeed);
  }

  @override
  Future<bool> deactivate(AccountID id) {
    deactivateFlag = true;
    return Future.value(_succeed);
  }
}
