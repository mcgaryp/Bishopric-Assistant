import 'package:the_assistant/firebase/firebase_authentication.dart';
import 'package:the_assistant/firebase/firestore_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:models/models/account.dart';
import 'package:models/shared/exceptions/exceptions.dart';

///
/// $FILE_NAME.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 3/16/22
/// Copyright 2022 Porter McGary. All rights reserved.
///

class FirestoreAccountRepository extends FirestoreHelper
    implements AccountRepository {
  FirestoreAccountRepository() : super(FirestoreCollectionPath.accounts);

  FirestoreCollectionPath _namePath = FirestoreCollectionPath.name;
  FirestoreCollectionPath _contactPath = FirestoreCollectionPath.contact;
  FirestoreCollectionPath _credentialsPath =
      FirestoreCollectionPath.credentials;

  @override
  Future<bool> activate(AccountID id) {
    // TODO: implement activate
    throw UnimplementedError("Account Activate");
  }

  @override
  Future<bool> deactivate(AccountID id) {
    // TODO: implement deactivate
    throw UnimplementedError("Account Deactivate");
  }

  @override
  Future<Account?> find(AccountID id) async {
    // pull out db account
    DBAccount dbAccount = DBAccount.fromMap(await getSingleDocument(id));

    // pull all components from related tables
    DBContact dbContact = DBContact.fromMap(await getSingleDocument(
      dbAccount.toContactID,
      path: _contactPath,
    ));
    DBCredentials dbCredentials = DBCredentials.fromMap(await getSingleDocument(
      dbAccount.toCredentialsID,
      path: _credentialsPath,
    ));
    DBName dbName = DBName.fromMap(await getSingleDocument(
      AccountID(dbAccount.nameID ?? ""),
      path: _namePath,
    ));

    // create Account
    Account account = Account(
      name: dbName.toName,
      contact: dbContact.toContact,
      credentials: dbCredentials.toCredentials,
      id: dbAccount.toAccountID,
    );

    // return account
    return account;
  }

  @override
  Future<Account?> findByUsername(String username) async {
    List<DBAccount> dbAccounts = (await getCollectionOfDocuments())
        .map<DBAccount>((Map<String, dynamic> map) => DBAccount.fromMap(map))
        .toList();

    for (DBAccount dbAccount in dbAccounts) {
      DBCredentials dbCredentials = DBCredentials.fromMap(
          await getSingleDocument(dbAccount.toCredentialsID,
              path: _credentialsPath));
      if (dbCredentials.toCredentials.username == username) {
        return find(dbAccount.toAccountID);
      }
    }
    return null;
  }

  @override
  Future<bool> insert(Account account) async {
    User? user = await FirebaseAuthentication.registerUsingEmailPassword(
        name: account.name.fullName,
        email: account.contact.email,
        password: account.credentials.password);
    if (user == null)
      throw FailedToSaveError(reason: "Account in Firebase Auth");
    // TODO: Create ActionCodeSetting that is sent with emailVerification
    // https://firebase.flutter.dev/docs/auth/usage/#open-link-in-app
    user.sendEmailVerification();

    // break the account down to its components
    DBCredentials dbCredentials =
        DBCredentials.fromCredentials(account.credentials);
    DBName dbName = DBName.fromName(account.name);
    DBContact dbContact = DBContact.fromContact(account.contact);

    // insert all components into their own tables
    String? credentialsID =
        await addDocument(dbCredentials.toMap, path: _credentialsPath);

    String? nameID = await addDocument(dbName.toMap, path: _namePath);

    String? contactID = await addDocument(dbContact.toMap, path: _contactPath);

    // update ids
    dbCredentials.id = credentialsID;
    await updateDocument(dbCredentials.toMap, AccountID(dbCredentials.id ?? ""),
        path: _credentialsPath);

    dbName.id = nameID;
    await updateDocument(dbName.toMap, AccountID(dbName.id ?? ""),
        path: _namePath);

    dbContact.id = contactID;
    await updateDocument(dbContact.toMap, AccountID(dbContact.id ?? ""),
        path: _contactPath);

    // create DB Account
    DBAccount dbAccount = DBAccount.fromDBs(
      dbContact: dbContact,
      dbName: dbName,
      dbCredentials: dbCredentials,
      isActive: true,
    );

    // insert db account
    String? accountID = await addDocument(dbAccount.toMap);

    // update account ID
    dbAccount.accountID = accountID;
    return updateDocument(dbAccount.toMap, dbAccount.toAccountID);
  }

  @override
  Future<bool> login(AccountID id) async {
    Account? account = await find(id);
    if (account == null) return false;
    User? user = await FirebaseAuthentication.signInUsingEmailPassword(
        email: account.contact.email, password: account.credentials.password);
    if (user == null) throw AccountNotFoundError();
    if (!user.emailVerified) throw VerifyEmailError();
    return true;
  }

  @override
  Future<bool> logout() {
    return FirebaseAuthentication.logout();
  }

  @override
  Future<bool> update(Account account) {
    // TODO: implement update
    throw UnimplementedError("Account Update");
  }
}
