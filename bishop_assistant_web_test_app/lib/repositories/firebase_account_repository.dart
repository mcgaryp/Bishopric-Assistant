import 'package:bishop_assistant_web_test_app/database/firestore_helper.dart';
import 'package:bishop_assistant_web_test_app/state/firebase_authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
        else {
          User? user = await FirebaseAuthentication.signInUsingEmailPassword(
              email: account.contact.email,
              password: account.credentials.password);
          if (user == null) throw AccountNotFoundError();
          return account;
        }
      }
    }
  }

  @override
  Future<Account?> insert(Account account) async {
    Map<String, dynamic> map = account.toMap;
    map[_accountActiveFlag] = true;
    User? user = await FirebaseAuthentication.registerUsingEmailPassword(
        name: account.name.fullName,
        email: account.contact.email,
        password: account.credentials.password);
    if (user == null)
      throw FailedToSaveError(forEntity: "Account in Firebase Auth");
    // TODO: Create ActionCodeSetting that is sent with emailVerification
    // https://firebase.flutter.dev/docs/auth/usage/#open-link-in-app
    user.sendEmailVerification();
    String? id = await addDocument(map);
    if (id == null) return null;
    return Account.fromMap(AccountID(id), account.toMap);
  }

  @override
  Future<bool> remove(AccountID id) {
    return updateDocument({_accountActiveFlag: false}, id);
  }

  @override
  Future<bool> update(Account account) async {
    if (await updateDocument(account.toMap, account.id)) {
      Account? oldAccount = await find(account.id);
      if (oldAccount == null) throw AccountNotFoundError();

      // if both are changed
      if (oldAccount.credentials.password != account.credentials.password &&
          oldAccount.contact.email != account.contact.email) {
        return await FirebaseAuthentication.updateEmail(
                account.contact.email, oldAccount.credentials.password) &&
            await FirebaseAuthentication.updatePassword(
                account.contact.email, account.credentials.password);
      }
      // if email changed
      if (oldAccount.contact.email != account.contact.email) {
        return await FirebaseAuthentication.updateEmail(
            account.contact.email, oldAccount.credentials.password);
      }
      // if password changed
      if (oldAccount.credentials.password != account.credentials.password) {
        return await FirebaseAuthentication.updatePassword(
            oldAccount.contact.email, account.credentials.password);
      }
      return true;
    }
    return false;
  }

  @override
  Future<bool> activate(AccountID id) {
    return updateDocument({_accountActiveFlag: true}, id);
  }

  @override
  Future<bool> login(Account account) async {
    User? user = await FirebaseAuthentication.signInUsingEmailPassword(
        email: account.contact.email, password: account.credentials.password);
    if (user == null) throw AccountNotFoundError();
    if (!user.emailVerified) throw VerifyEmailError();
    return true;
  }

  @override
  Future<bool> logout() async {
    return await FirebaseAuthentication.logout();
  }
}
