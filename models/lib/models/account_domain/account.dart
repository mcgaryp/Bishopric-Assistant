import 'package:models/models/account.dart';
import 'package:models/shared/foundation.dart';

///
/// account.dart
/// bishopric-assistant
///
/// Created by Po on 9/28/21
/// Copyright 2021 Po. All rights reserved.
///

/// TODO: Does an account have a role?
class Account extends Entity<Account> {
  final AccountID id;
  final Name name;
  final Contact contact;
  final Credentials credentials;
  final Role role;

  Account(
      {required this.id,
      required this.name,
      required this.contact,
      required this.credentials,
      required this.role})
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
