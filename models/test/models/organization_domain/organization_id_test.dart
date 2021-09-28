import 'package:flutter_test/flutter_test.dart';
import 'package:models/models/organization_domain/organization_id.dart';

///
/// organization_id_test.dart
/// bishopric-assistant
///
/// Created by Po on 9/23/21
/// Copyright 2021 Po. All rights reserved.
///

class OrganizationIDTest {
  static void checkOrganizationID() {
    // Arrange
    OrganizationID id = OrganizationID("9");
    // Act
    String result = id.id;
    // Assert
    expect(result, "9");
  }
}

main() {
  group("OrganizationID Test", () {
    test("check the id sets right", OrganizationIDTest.checkOrganizationID);
  });
}
