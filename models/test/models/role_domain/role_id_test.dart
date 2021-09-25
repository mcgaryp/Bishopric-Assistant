import 'package:flutter_test/flutter_test.dart';
import 'package:models/models/role.dart';

///
/// role_id_test.dart
/// bishopric-assistant
///
/// Created by Po on 9/24/21
/// Copyright 2021 Po. All rights reserved.
///

class RoleIDTest {
  static void idCheck() {
    RoleID id = RoleID(19);
    int result = id.id;
    expect(result, 19);
  }
}

main() {
  test("RoleID Test id is properly stored", RoleIDTest.idCheck);
}
