import 'package:models/models/role.dart';
import 'package:models/shared/value_object.dart';
import 'package:models/util/extensions/extensions.dart';

import 'security_clearance.dart';

///
/// role.dart
/// bishopric-assistant
///
/// Created by Po on 9/22/21
/// Copyright 2021 Po. All rights reserved.
///

// TODO: Is this a [ValueObject] or an [Entity]
class Role extends ValueObject<Role> {
  late final RoleID id;
  late final String _name;
  late final SecurityClearance securityClearance;

  Role(this.id, {required this.securityClearance, required String name})
      : super.decode({}) {
    __name = name;
  }

  Role.creator() : super.decode({}) {
    id = RoleID(0);
    __name = "Creator";
    securityClearance = SecurityClearance.creator;
  }

  String get name => _name;
  set __name(String name) {
    _name = name.capitalize;
  }

  @override
  bool sameValueAs(Role other) {
    return this.id == other.id;
  }

  @override
  Map<String, dynamic> toJson() {
    return {"id": id.id, "name": name, "securityID": securityClearance.index};
  }
}
