import 'package:models/models/account.dart';
import 'package:models/shared/repository.dart';

///
/// account_repository.dart
/// bishopric-assistant
///
/// Created by Po on 9/28/21
/// Copyright 2021 Po. All rights reserved.
///

/// [AccountRepository] is an interface specifically for interfacing with the
///   [Account] backend
mixin AccountRepository implements Repository<Account, AccountID, void> {
  /// [findByUsername] uses a string username to find and return an optional
  ///   [Account]
  Future<Account?> findByUsername(String username);

  /// [findByPhone] uses a string phone to find and return an optional [Account]
  Future<Account?> findByPhone(String phone);

  /// [findByPhone] uses a string phone to find and return an optional [Account]
  Future<Account?> findByEmail(String email);

  /// [login] stores a value to mark the user as logged in
  Future<bool> login();

  /// [logout] stores a value to mark the user as logged out
  Future<bool> logout();

  /// [getLoginStatus] retrieves current status of the login state
  Future<LoginStatus> getLoginStatus();

  /// [getCache] retrieves the cache from storage
  Future<Account> getCache();

  Future<bool> cache(Account account);

  Future<bool> activate(AccountID id);
}
