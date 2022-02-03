import 'package:models/models/organization.dart';
import 'package:models/shared/foundation.dart';

///
/// role.dart
/// bishopric-assistant
///
/// Created by Po on 9/28/21
/// Copyright 2021 Po. All rights reserved.
///

/// [Role] and permission of the role of a given user
class Role extends ValueObject<Role> {
  final Permissions permissions;
  late final String _anonymous;
  static const String anonymousKey = "anonymous";
  static const String permissionsKey = "character";

  Role(this.permissions, {required String anonymous}) {
    __anonymous = anonymous;
  }

  Role.creator() : permissions = Permissions.Creator {
    __anonymous = "Owner";
  }

  Role.fromMap(Map<String, dynamic> map)
      : this(PermissionsExtension.fromString(map[permissionsKey]),
            anonymous: map[anonymousKey]);

  set __anonymous(String anonymous) {
    if (anonymous.isEmpty) throw EmptyStringError(forObject: "Role Anonymous");
    _anonymous = anonymous;
  }

  String get anonymous => _anonymous;

  @override
  bool sameValueAs(Role other) {
    return other.permissions == this.permissions &&
        other.anonymous == this.anonymous;
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != Role) return false;
    return sameValueAs(other as Role);
  }

  @override
  Map<String, dynamic> get toMap =>
      {permissionsKey: permissions.string, anonymousKey: anonymous};

  @override
  String toString() {
    return "$anonymous: $permissions";
  }
}
