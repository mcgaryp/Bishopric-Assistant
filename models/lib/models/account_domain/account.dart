import 'package:models/models/account.dart';
import 'package:models/shared/foundation.dart';

///
/// account.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 9/28/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

/// [Account] holds the valuable information of an application user
class Account extends Entity<Account> {
  static const String contactKey = "Account Contact";
  static const String nameKey = "Account Name";
  static const String credentialsKey = "Account Credentials";
  static const String idKey = "Account ID";

  /// [id] unique identifier of the account
  final AccountID? _id;

  /// [name] describes the account names
  final Name name;

  /// [contact] information of the account
  Contact contact;

  /// [credentials] describes the specific login information connected to the account
  Credentials credentials;

  /// Constructors
  ///
  /// Main constructor of an [Account]
  Account({
    AccountID? id,
    required this.name,
    required this.contact,
    required this.credentials,
  })  : this._id = id,
        super(id);

  Account.fromMap(Map<String, dynamic> map)
      : this(
            id: map[idKey] == null ? null : AccountID(map[idKey]),
            credentials: Credentials.fromMap(map[credentialsKey]),
            contact: Contact.fromMap(map[contactKey]),
            name: Name.fromMap(map[nameKey]));

  AccountID get id {
    if (_id == null) throw IdDoesNotExistError(forObject: "Account");
    return _id!;
  }

  @override
  bool sameIdentityAs(Account other) {
    return other._id == this._id &&
        other.name == this.name &&
        other.contact == this.contact &&
        other.credentials == this.credentials;
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != Account) return false;
    return sameIdentityAs(other as Account);
  }

  @override
  String toString() {
    return """
    Name: ${name.toString()}
    Credentials: ${credentials.toString()}
    Contact: ${contact.toString()}
    ID: ${_id?.id}
    """;
  }

  @override
  Map<String, dynamic> get toMap => {
        idKey: _id?.id,
        nameKey: name.toMap,
        contactKey: contact.toMap,
        credentialsKey: credentials.toMap,
      };
}
