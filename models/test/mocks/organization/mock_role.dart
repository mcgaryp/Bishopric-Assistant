import 'package:models/models/organization.dart';

import 'mock_authorization.dart';

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

  MockRole({Authorization? authorization, String? anonymous}) {
    role = Role(
      name: anonymous ?? mockAnonymous,
      authorization: authorization ?? MockAuthorization().authorization,
      id: RoleID("Fake Role ID"),
    );
  }
}
