import 'package:models/models/account.dart';

///
/// account_repository.dart
/// bishopric-assistant
///
/// Created by Po on 9/28/21
/// Copyright 2021 Po. All rights reserved.
///

/// [AccountRepository] is an interface specifically for interfacing with the
///   [Account] backend
mixin AccountRepository {
  /// [find] uses the accountID to find an account from a repository
  Future<Account?> find(AccountID id);

  /// [insert] inputs account information into a repository
  Future<bool> insert(Account account);

  /// [update] updates the values of a given account via AccountID and map
  Future<bool> update(Account account);

  /// [findByUsername] uses a string username to find and return an optional
  ///   [Account]
  Future<Account?> findByUsername(String username);

  /// [login] stores a value to mark the user as logged in
  Future<bool> login(AccountID id);

  /// [logout] stores a value to mark the user as logged out
  Future<bool> logout();

  /// [activate] enables the user account
  Future<bool> activate(AccountID id);

  /// [deactivate] disables the user account
  Future<bool> deactivate(AccountID id);
}
