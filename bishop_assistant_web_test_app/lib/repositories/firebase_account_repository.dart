import 'package:async/src/result/result.dart';
import 'package:bishop_assistant_web_test_app/database/FirestoreHelper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:models/models/account.dart';

///
/// firebase_account_repository.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 10/27/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

class FirebaseAccountRepository extends FirestoreHelper
    implements AccountRepository {
  FirestoreCollectionPath _path = FirestoreCollectionPath.accounts;

  @override
  Future<Account?> find(AccountID id) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await FirestoreHelper.getSingleDocument(_path, id);

    Map<String, dynamic>? map = snapshot.data();

    if (map == null) return null;

    Account account = Account.fromJson(id, map);
    return account;
  }

  @override
  Future<List<Account>?> findAll(void nil) {
    // TODO: implement findAll
    throw UnimplementedError();
  }

  @override
  Future<Account?> findByEmail(String email) {
    // TODO: implement findByEmail
    throw UnimplementedError();
  }

  @override
  Future<Account?> findByPhone(String phone) {
    // TODO: implement findByPhone
    throw UnimplementedError();
  }

  @override
  Future<Account?> findByUsername(String username) async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirestoreHelper.getCollectionOfDocuments(_path);
    for (QueryDocumentSnapshot<Map<String, dynamic>> map in snapshot.docs) {
      if (map.get('username') == username)
        return Account.fromJson(AccountID(map.id), map.data());
    }
  }

  @override
  Future<AccountID?> generateNextId() async {
    Map<String, dynamic>? snapshot = await FirestoreHelper.getNextID();
    if (snapshot == null) return null;
    String id = snapshot[_path.string].toString();
    if (id.isEmpty) return null;
    AccountID accountID = AccountID(id);

    snapshot[_path.string] += 1;
    bool success = await FirestoreHelper.incrementId(_path, snapshot);
    if (!success) return null;

    return accountID;
  }

  @override
  Future<bool> insert(Account account) async {
    bool result =
        await FirestoreHelper.addDocument(_path, account.toJson, account.id);

    return result;
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
