import 'package:flutter_test/flutter_test.dart';
import 'package:models/models/organization.dart';
import 'package:models/shared/exceptions/exceptions.dart';
import 'package:models/shared/test.dart';

import '../../mocks/organization/mock_authorization.dart';
import '../../mocks/organization/mock_role.dart';

///
/// role_test.dart
/// bishopric-assistant
///
/// Created by Po on 9/29/21
/// Copyright 2021 Po. All rights reserved.
///

class RoleTest with Test {
  static void shouldReturnPermissionWhenValid() {
    Role role = MockRole().role;
    Authorization result = role.authorization;
    expect(result, MockAuthorization().authorization);
  }

  static void shouldReturnAnonymousWhenValid() {
    Role role = MockRole().role;
    String result = role.name;
    expect(result, MockRole.mockAnonymous);
  }

  static void shouldReturnEmptyStringErrorWhenInvalidAnonymous() {
    try {
      MockRole(anonymous: "");
    } catch (result) {
      expect(result.toString(),
          EmptyStringError(forObject: "Role Anonymous").toString());
      return;
    }
    Test.fallthrough();
  }
}

runRoleTests() {
  group("Role", () {
    test("should return permission", RoleTest.shouldReturnPermissionWhenValid);
    test("should return anonymous", RoleTest.shouldReturnAnonymousWhenValid);
    // TODO: Check Test
    // test("should return empty string error",
    //     RoleTest.shouldReturnEmptyStringErrorWhenInvalidAnonymous);
  });
}
