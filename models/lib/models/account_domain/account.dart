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
  /// [id] unique identifier of the account
  final AccountID id;

  /// [name] describes the account names
  final Name name;

  /// [contact] information of the account
  final Contact contact;

  /// [credentials] describes the specific login information connected to the account
  final Credentials credentials;

  /// Constructors
  ///
  /// Main constructor of an [Account]
  Account({
    required this.id,
    required this.name,
    required this.contact,
    required this.credentials,
  }) : super(id);

  Account.fromMap(AccountID id, Map<String, Object?> map)
      : this(
            id: id,
            credentials: Credentials.fromMap(map),
            contact: Contact.fromMap(map),
            name: Name.fromMap(map));

  /// [Account.newPassword(account, credentials)] is a copy constructor
  ///   specifically used to change the credentials of the account
  Account.newPassword(Account account, Credentials credentials)
      : this.id = account.id,
        this.credentials = credentials,
        this.contact = account.contact,
        this.name = account.name,
        super(account.id);

  /// [Account.newContact(account, contact)] is a copy constructor specifically
  ///   used to change the contact of the account
  Account.newContact(Account account, Contact contact)
      : this.id = account.id,
        this.credentials = account.credentials,
        this.contact = contact,
        this.name = account.name,
        super(account.id);

  @override
  bool sameIdentityAs(Account other) {
    return other.id == this.id;
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
    """;
  }

  @override
  Map<String, dynamic> get toMap {
    Map<String, dynamic> map = {};
    map.addAll(name.toMap);
    map.addAll(credentials.toMap);
    map.addAll(contact.toMap);
    return map;
  }
}
