import 'package:bishop_assistant_web_test_app/firebase/firebase_authentication.dart';
import 'package:bishop_assistant_web_test_app/firebase/firestore_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:models/models/account.dart';
import 'package:models/shared/exceptions/exceptions.dart';

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
    Map<String, dynamic>? map = await getSingleDocument(id);
    if (map == null) return null;
    if (map[_accountActiveFlag] == false) return null;
    Account account = Account.fromMap(map);
    return account;
  }

  @override
  Future<Account?> findByEmail(String email) async {
    List<Map<String, dynamic>> snapshot = await getCollectionOfDocuments();
    for (Map<String, dynamic> map in snapshot) {
      if (map[Account.contactKey][Contact.emailKey] == email) {
        return Account.fromMap(map);
      }
    }
  }

  @override
  Future<Account?> findByPhone(String phone) async {
    List<Map<String, dynamic>> snapshot = await getCollectionOfDocuments();
    for (Map<String, dynamic> map in snapshot) {
      if (map[Account.contactKey][Contact.phoneKey] == phone) {
        return Account.fromMap(map);
      }
    }
  }

  @override
  Future<Account?> findByUsername(String username) async {
    List<Map<String, dynamic>> snapshot = await getCollectionOfDocuments();
    for (Map<String, dynamic> map in snapshot) {
      if (map[Account.credentialsKey][Credentials.usernameKey] == username) {
        Account account = Account.fromMap(map);
        if (map[_accountActiveFlag] == false)
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
      throw FailedToSaveError(reason: "Account in Firebase Auth");
    // TODO: Create ActionCodeSetting that is sent with emailVerification
    // https://firebase.flutter.dev/docs/auth/usage/#open-link-in-app
    user.sendEmailVerification();
    String? id = await addDocument(map);
    if (id == null) return null;
    map[Account.idKey] = id;
    Account newAccount = Account.fromMap(map);
    if (await updateDocument(newAccount.toMap, newAccount.id))
      return newAccount;
  }

  @override
  Future<bool> remove(AccountID id) {
    return updateDocument({_accountActiveFlag: false}, id);
  }

  @override
  Future<bool> update(Account account) async {
    Account? oldAccount = await find(account.id);
    if (await updateDocument(account.toMap, account.id)) {
      if (oldAccount == null) throw AccountNotFoundError();
      bool result;
      // if both are changed
      if (oldAccount.credentials.password != account.credentials.password &&
          oldAccount.contact.email != account.contact.email) {
        result = await FirebaseAuthentication.updateEmail(
                account.contact.email, oldAccount.credentials.password) &&
            await FirebaseAuthentication.updatePassword(
                account.contact.email, account.credentials.password);
        await FirebaseAuthentication.user.sendEmailVerification();
        return result;
      }
      // if email changed
      if (oldAccount.contact.email != account.contact.email) {
        result = await FirebaseAuthentication.updateEmail(
            account.contact.email, oldAccount.credentials.password);
        await FirebaseAuthentication.user.sendEmailVerification();
        return result;
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

  @override
  Stream<Account> findStreamed(AccountID id) {
    return getSingleDocumentStreamed(id)
        .map<Account>((Map<String, dynamic>? map) => Account.fromMap(map!));
  }
}
