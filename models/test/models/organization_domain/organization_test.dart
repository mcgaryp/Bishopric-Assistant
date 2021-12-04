import 'package:flutter_test/flutter_test.dart';
import 'package:models/models/organization.dart';

import '../../mocks/organization/mock_organization.dart';

///
/// organization_test.dart
/// bishopric-assistant
///
/// Created by Po on 9/23/21
/// Copyright 2021 Po. All rights reserved.
///

class OrganizationTests {
  static shouldReturnValidNameWhenGivenName() {
    Organization organization = MockOrganization().organization;
    expect(organization.name, MockOrganization.mockName);
  }
}

runOrganizationTests() {
  group("Organization", () {
    test("Organization name",
        OrganizationTests.shouldReturnValidNameWhenGivenName);
  });
}
