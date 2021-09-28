import 'package:models/models/role.dart';
import 'package:models/shared/value_object.dart';
import 'package:models/util/extensions/extensions.dart';

import 'role_id.dart';
import 'security_clearance.dart';

///
/// role.dart
/// bishopric-assistant
///
/// Created by Po on 9/22/21
/// Copyright 2021 Po. All rights reserved.
///

/// TODO: Implement Role, Refer to [ReadMe.md](models/README.md)
/// TODO: Comments
class Role extends ValueObject<Role> {
  final RoleID id;
  late final String _name;
  late final SecurityClearance securityClearance;

  Role(
      {required this.id, required this.securityClearance, required String name})
      : super.decode({}) {
    __name = name;
  }

  Role.creator()
      : this.id = RoleID.creatorID(),
        super.decode({}) {
    __name = "Creator";
    securityClearance = SecurityClearance.creator;
  }

  String get name => _name;
  set __name(String name) {
    _name = name.capitalize;
  }

  @override
  bool operator ==(Object other) {
    return sameValueAs(other as Role);
  }

  @override
  bool sameValueAs(Role other) {
    return this.name == other.name;
  }

  @override
  Map<String, dynamic> toJson() {
    return {"name": name, "securityID": securityClearance.index};
  }
}
