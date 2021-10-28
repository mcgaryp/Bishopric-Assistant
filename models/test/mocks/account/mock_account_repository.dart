import 'dart:math';

import 'package:models/models/account.dart';
import 'package:models/shared/exceptions.dart';
import 'package:models/shared/repository.dart';

import 'mock_account.dart';

export 'package:async/src/result/result.dart';

///
/// mock_account_repository.dart
/// bishopric-assistant
///
/// Created by Po on 9/29/21
/// Copyright 2021 Po. All rights reserved.
///

class MockAccountRepository implements AccountRepository {
  final List<Account> accounts = List.generate(
      25, (index) => MockAccount(id: AccountID("Mock $index")).account);
  final Duration duration = Duration(seconds: 1);
  int id = 25;

  @override
  Future<Account?> find(AccountID id) async {
    await Future.delayed(duration);
    for (Account account in accounts) {
      if (account.id == id) return account;
    }
  }

  @override
  Future<List<Account>?> findAll(void o) async {
    await Future.delayed(duration);
    return accounts;
  }

  @override
  Future<Account?> findByPhone(String phone) async {
    await Future.delayed(duration);
    for (Account account in accounts)
      if (account.contact.phone == phone) return account;
  }

  @override
  Future<Account?> findByUsername(String username) async {
    await Future.delayed(duration);
    for (Account account in accounts)
      if (account.credentials.username == username) return account;
  }

  @override
  Future<AccountID?> generateNextId() async {
    await Future.delayed(duration);
    AccountID id = AccountID("Mock ${this.id}");
    this.id++;
    return id;
  }

  @override
  Future<bool> insert(Account account) async {
    await Future.delayed(duration);
    bool succeeded = 1 == Random().nextInt(2);
    if (succeeded) {
      accounts.add(account);
      return true;
    }
    return false;
  }

  @override
  Future<Result<bool>> remove(AccountID id) async {
    await Future.delayed(duration);
    for (Account account in accounts) {
      if (account.id == id) {
        if (accounts.remove(account))
          return Result.value(true);
        else
          Result.error(FailedToRemoveError(forEntity: "Account"));
      }
    }
    return Result.error(AccountNotFoundError());
  }

  @override
  Future<bool> update(Account account) async {
    await Future.delayed(duration);
    bool succeeded = 1 == Random().nextInt(2);
    if (succeeded) {
      int index = accounts.indexWhere((element) => element == account);
      accounts[index] = account;
      return true;
    }
    return false;
  }

  @override
  Future<Account?> findByEmail(String email) {
    // TODO: implement findByEmail
    throw UnimplementedError();
  }
}