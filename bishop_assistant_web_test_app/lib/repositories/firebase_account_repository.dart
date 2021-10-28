import 'package:async/src/result/result.dart';
import 'package:bishop_assistant_web_test_app/database/FirestoreHelper.dart';
import 'package:models/models/account.dart';

///
/// firebase_account_repository.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 10/27/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

class FirebaseAccountRepository extends FirestoreHelper implements AccountRepository {
  @override
  Future<Account?> find(AccountID id) {
    // TODO: implement find
    throw UnimplementedError();
  }

  @override
  Future<List<Account>?> findAll(void nil) {
    // TODO: implement findAll
    throw UnimplementedError();
  }

  @override
  Future<Account?> findByPhone(String phone) {
    // TODO: implement findByPhone
    throw UnimplementedError();
  }

  @override
  Future<Account?> findByUsername(String username) {
    // TODO: implement findByUsername
    throw UnimplementedError();
  }

  @override
  Future<AccountID?> generateNextId() {
    // TODO: implement generateNextId
    throw UnimplementedError();
  }

  @override
  Future<bool> insert(Account account) {
    // TODO: implement insert
    throw UnimplementedError();
  }

  @override
  Future<Result<bool>> remove(AccountID id) {
    // TODO: implement remove
    throw UnimplementedError();
  }

  @override
  Future<bool> update(Account account) {
    // TODO: implement update
    throw UnimplementedError();
  }
}