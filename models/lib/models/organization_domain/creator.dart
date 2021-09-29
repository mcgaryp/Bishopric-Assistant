import 'package:models/models/account.dart';
import 'package:models/models/account_domain/account_id.dart';
import 'package:models/shared/entity.dart';

///
/// creator.dart
/// bishopric-assistant
///
/// Created by Po on 9/28/21
/// Copyright 2021 Po. All rights reserved.
///

class Creator extends Entity<Creator> {
  late final Name name;
  late final Role role;
  late final AccountID id;

  Creator({required this.id, required this.name, String? anonymous})
      : super(id) {
    role = Role(Permissions.creator, anonymous: anonymous ?? "Creator");
  }

  Creator.fromAccount(Account account, {String? anonymous})
      : super(account.id) {
    name = account.name;
    role = Role(Permissions.creator, anonymous: anonymous ?? "Creator");
    id = account.id;
  }

  @override
  bool sameIdentityAs(Creator other) {
    return this.id == other.id;
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != Creator) return false;
    return sameIdentityAs(other as Creator);
  }
}
