import 'package:models/models/organization.dart';

///
/// mock_role.dart
/// bishopric-assistant
///
/// Created by Po on 9/29/21
/// Copyright 2021 Po. All rights reserved.
///

class MockRole {
  static final String mockAnonymous = "Mock Role";
  static final Permissions mockPermissions = Permissions.creator;

  late final Role role;

  MockRole({Permissions? permissions, String? anonymous}) {
    role = Role(permissions ?? mockPermissions,
        anonymous: anonymous ?? mockAnonymous);
  }
}
