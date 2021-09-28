import 'package:models/models/accounts/account_id.dart';
import 'package:models/models/accounts/contact.dart';
import 'package:models/models/accounts/credentials.dart';
import 'package:models/models/accounts/name.dart';
import 'package:models/models/accounts/role.dart';
import 'package:models/shared/entity.dart';

///
/// account.dart
/// bishopric-assistant
///
/// Created by Po on 9/28/21
/// Copyright 2021 Po. All rights reserved.
///

class Account extends Entity<Account> {
  final AccountID id;
  final Name name;
  final Contact contact;
  final Credentials credentials;
  final Role role;

  Account(this.id, this.name, this.contact, this.credentials, this.role)
      : super(id);

  @override
  bool sameIdentityAs(Account other) {
    return other.id == this.id;
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != Account) return false;
    return sameIdentityAs(other as Account);
  }
}
