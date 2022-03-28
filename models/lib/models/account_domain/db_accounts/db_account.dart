import 'package:models/models/account.dart';
import 'package:models/shared/exceptions/exceptions.dart';

///
/// $FILE_NAME.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 3/16/22
/// Copyright 2022 Porter McGary. All rights reserved.
///

class DBAccount {
  static const String accountIDKey = "Account ID";
  static const String contactIDKey = "Account contact ID";
  static const String nameIDKey = "Account name ID";
  static const String credentialsIDKey = "Account credential ID";
  static const String isActiveKey = "Account isActive";

  String? accountID;
  String? contactID;
  String? nameID;
  String? credentialsID;
  bool? isActive;

  DBAccount(
      {this.accountID,
      this.contactID,
      this.credentialsID,
      this.isActive,
      this.nameID});

  DBAccount.fromMap(Map<String, dynamic> map)
      : this(
          accountID: map[accountIDKey],
          contactID: map[contactIDKey],
          nameID: map[nameIDKey],
          credentialsID: map[credentialsIDKey],
          isActive: map[isActiveKey],
        );

  DBAccount.fromDBs({
    required DBContact dbContact,
    required DBCredentials dbCredentials,
    required DBName dbName,
    required bool isActive,
  }) : this(
          contactID: dbContact.id,
          credentialsID: dbCredentials.id,
          isActive: isActive,
          nameID: dbName.id,
        );

  Map<String, dynamic> get toMap => {
        accountIDKey: accountID,
        contactIDKey: contactID,
        nameIDKey: nameID,
        credentialsIDKey: credentialsID,
        isActiveKey: isActive,
      };

  AccountID get toAccountID {
    accountID ?? (throw IdDoesNotExistError(forObject: "DB Account ID"));
    return AccountID(accountID!);
  }

  AccountID get toContactID {
    contactID ?? (throw IdDoesNotExistError(forObject: "DB Account Contact ID"));
    return AccountID(contactID!);
  }

  AccountID get toCredentialsID {
    credentialsID ?? (throw IdDoesNotExistError(forObject: "DB Account Credentials ID"));
    return AccountID(credentialsID!);
  }
}
