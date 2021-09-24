import 'package:models/models/role.dart';
import 'package:models/shared/value_object.dart';

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
  late final String name;
  late final SecurityClearance securityClearance;

  Role(this.id, {required this.securityClearance, required this.name})
      : super.decode({});
  Role.creator() : super.decode({}) {
    id = RoleID(0);
    name = "Creator";
    securityClearance = SecurityClearance.creator;
  }

  @override
  bool sameIdentityAs(other) {
    // TODO: implement sameIdentityAs
    throw UnimplementedError();
  }

  @override
  bool sameValueAs(Role other) {
    // TODO: implement sameValueAs
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}
