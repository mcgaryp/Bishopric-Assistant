import 'package:models/models/organization.dart';
import 'package:models/shared/domain_driven_design/entity.dart';
import 'package:models/shared/exceptions/exceptions.dart';

///
/// $FILE_NAME.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 3/18/22
/// Copyright 2022 Porter McGary. All rights reserved.
///

class Role extends Entity<Role> {
  static const String nameKey = "Role Name";
  static const String authorizationKey = "Role Authorization";
  static const String idKey = "Role ID";

  final Authorization authorization;
  late String _name;
  RoleID? _id;

  Role({required this.authorization, required String name, RoleID? id})
      : this._id = id,
        super(id) {
    __name = name;
  }

  Role.fromMap(Map<String, dynamic> map)
      : this(
          authorization: Authorization.fromMap(map[authorizationKey]),
          name: map[nameKey],
          id: map[idKey] == null ? null : RoleID(map[idKey]),
        );

  set __name(String name) {
    if (name.isEmpty) throw EmptyStringError(forObject: "Role Name");
    _name = name;
  }

  set roleID(RoleID id) => _id = id;

  String get name => _name;

  RoleID get id {
    _id ?? (throw IdDoesNotExistError(forObject: "Role ID"));
    return _id!;
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != Role) return false;
    return sameIdentityAs(other as Role);
  }

  @override
  Map<String, dynamic> get toMap => {
        nameKey: name,
        authorizationKey: authorization.toMap,
        idKey: _id?.id,
      };

  @override
  String toString() {
    return "$name: $authorization";
  }

  @override
  bool sameIdentityAs(Role other) {
    return other.authorization == this.authorization && other.name == this.name;
  }
}
