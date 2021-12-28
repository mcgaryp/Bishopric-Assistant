import 'package:bishop_assistant_web_test_app/database/firestore_helper.dart';
import 'package:bishop_assistant_web_test_app/database/shared_preferences_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:models/models/account.dart';
import 'package:models/shared/exceptions.dart';

///
/// firebase_account_repository.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 10/27/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

class FirebaseAccountRepository extends FirestoreHelper
    implements AccountRepository {
  String _loginKey = "loginStatus";
  String _accountKey = "accountInfo";
  static const String _accountActiveFlag = "isActive";

  FirebaseAccountRepository() : super(FirestoreCollectionPath.accounts);

  @override
  Future<Account?> find(AccountID id) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await getSingleDocument(id);

    Map<String, dynamic>? map = snapshot.data();

    if (map == null) return null;
    if (map[_accountActiveFlag] == false) return null;

    Account account = Account.fromMap(id, map);
    return account;
  }

  @override
  Future<Account?> findByEmail(String email) async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await getCollectionOfDocuments();
    for (QueryDocumentSnapshot<Map<String, dynamic>> map in snapshot.docs) {
      if (map.get('email') == email)
        return Account.fromMap(AccountID(map.id), map.data());
    }
  }

  @override
  Future<Account?> findByPhone(String phone) async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await getCollectionOfDocuments();
    for (QueryDocumentSnapshot<Map<String, dynamic>> map in snapshot.docs) {
      if (map.get('phone') == phone)
        return Account.fromMap(AccountID(map.id), map.data());
    }
  }

  @override
  Future<Account?> findByUsername(String username) async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await getCollectionOfDocuments();
    for (QueryDocumentSnapshot<Map<String, dynamic>> map in snapshot.docs) {
      if (map.get('username') == username) {
        Account account = Account.fromMap(AccountID(map.id), map.data());
        if (map.get(_accountActiveFlag) == false)
          throw InactiveAccountError(account.id);
        else
          return account;
      }
    }
  }

  @override
  Future<Account?> insert(Account account) async {
    Map<String, dynamic> map = account.toMap;
    map[_accountActiveFlag] = true;
    String? id = await addDocument(map);
    if (id == null) return null;
    return Account.fromMap(AccountID(id), account.toMap);
  }

  @override
  Future<bool> remove(AccountID id) {
    return updateDocument({_accountActiveFlag: false}, id);
  }

  @override
  Future<bool> update(Account account) {
    return updateDocument(account.toMap, account.id);
  }

  @override
  Future<LoginStatus> getLoginStatus() async {
    String? status = await SharedPreferencesHelper.find(_loginKey);
    switch (status) {
      case "loggedOut":
        return LoginStatus.loggedOut;
      case "loggedIn":
        return LoginStatus.loggedIn;
      default:
        return LoginStatus.unknown;
    }
  }

  @override
  Future<bool> login() async {
    return await SharedPreferencesHelper.insert(
        _loginKey, LoginStatus.loggedIn.string);
  }

  @override
  Future<bool> logout() async {
    return await SharedPreferencesHelper.insert(
        _loginKey, LoginStatus.loggedOut.string);
  }

  @override
  Future<Account> getCache() async {
    Map<String, dynamic> map =
        await SharedPreferencesHelper.findMap(_accountKey);
    AccountID id = AccountID(map["id"]);
    Account account = Account.fromMap(id, map);
    return account;
  }

  @override
  Future<bool> cache(Account account) async {
    String value = account.toMap.toString();
    bool isSuccessful =
        await SharedPreferencesHelper.insert(_accountKey, value);
    return isSuccessful;
  }

  @override
  Future<bool> activate(AccountID id) {
    return updateDocument({_accountActiveFlag: true}, id);
  }
}
