import 'package:models/models/organization.dart';

import 'mock_permissions.dart';

///
/// mock_role.dart
/// bishopric-assistant
///
/// Created by Po on 9/29/21
/// Copyright 2021 Po. All rights reserved.
///

class MockRole {
  static final String mockAnonymous = "Mock Role";

  late final Role role;

  MockRole({Permissions? permissions, String? anonymous}) {
    role = Role(permissions ?? MockPermissions().permissions,
        anonymous: anonymous ?? mockAnonymous);
  }
}
