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
  bool removeFlag = false;
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
  Future<Account?> findByEmail(String email) {
    findByEmailFlag = true;
    if (email == account.contact.email) return Future.value(account);
    return Future.value(null);
  }

  @override
  Future<Account?> findByPhone(String phone) {
    findByPhoneFlag = true;
    if (phone == account.contact.phone) return Future.value(account);
    return Future.value(null);
  }

  @override
  Future<Account?> findByUsername(String username) {
    findByUsernameFlag = true;
    if (username == account.credentials.username) return Future.value(account);
    return Future.value(null);
  }

  @override
  Stream<Account> findStreamed(AccountID id) {
    findStreamedFlag = true;
    return Stream.value(account);
  }

  @override
  Future<Account?> insert(Account m) {
    insertFlag = true;
    if (shouldFail) return Future.value(null);
    return Future.value(account);
  }

  @override
  Future<bool> login(Account account) {
    loginFlag = true;
    return Future.value(_succeed);
  }

  @override
  Future<bool> logout() {
    logoutFlag = true;
    return Future.value(_succeed);
  }

  @override
  Future<bool> remove(AccountID i) {
    removeFlag = true;
    return Future.value(_succeed);
  }

  @override
  Future<bool> update(Account m) {
    updateFlag = true;
    return Future.value(_succeed);
  }
}
