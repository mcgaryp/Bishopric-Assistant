import 'package:flutter_test/flutter_test.dart';
import 'package:models/models/organization.dart';
import 'package:models/shared/exceptions/exceptions.dart';
import 'package:models/shared/test.dart';

import '../../mocks/organization/mock_member.dart';
import '../../mocks/organization/mock_organization.dart';

///
/// organization_test.dart
/// bishopric-assistant
///
/// Created by Po on 9/23/21
/// Copyright 2021 Po. All rights reserved.
///

class OrganizationTests implements Test {
  static void shouldReturnValidNameWhenGivenName() {
    Organization organization = MockOrganization().organization;
    expect(organization.name, MockOrganization.mockName);
  }

  // EQUIVALENCY
  static void verifyEquivalencyOperator() {
    Organization organization = MockOrganization().organization;
    expect(organization == organization, true);
    expect(organization == MockOrganization(id: null).organization, true);
    expect(
        organization ==
            MockOrganization(id: MockOrganizationID(id: "Different").id),
        false);
    expect(organization == MockOrganization(name: "different").organization,
        false);
    expect(
        organization ==
            MockOrganization(
                    creator:
                        MockMember(id: MockMemberID(id: "different").id).member)
                .organization,
        false);
  }

  // SAME IDENTITY AS
  static void verifySameIdentityAs() {
    Organization organization = MockOrganization().organization;
    expect(organization.sameIdentityAs(organization), true);
    expect(organization.sameIdentityAs(MockOrganization(id: null).organization),
        true);
    expect(
        organization.sameIdentityAs(
            MockOrganization(id: MockOrganizationID(id: "Different").id)
                .organization),
        false);
    expect(
        organization
            .sameIdentityAs(MockOrganization(name: "different").organization),
        false);
    expect(
        organization.sameIdentityAs(MockOrganization(
                creator:
                    MockMember(id: MockMemberID(id: "different").id).member)
            .organization),
        false);
  }

  // VERIFY THE ORGANIZATION ID GETTER
  // - when null id is given throw id doesn't exist error
  // - return valid id when id is not null
  static void verifyID() {
    // Expected
    MockOrganization(id: MockOrganizationID().id).organization.id;

    try {
      MockOrganization().organization.id;
      Test.fallthrough(notes: "Failed to notify of null id");
    } catch (error) {
      expect(error.toString(),
          IdDoesNotExistError(forObject: "Organization").toString());
    }
  }

  // VERIFY TO AND FROM MAPPING
  static void verifyMapping() {
    Organization organizationWithoutID = MockOrganization().organization;
    Map<String, dynamic> orgWithoutIDMap = organizationWithoutID.toMap;
    Organization organization = Organization.fromMap(orgWithoutIDMap);
    expect(organization == organizationWithoutID, true);

    Organization organizationWithID =
        MockOrganization(id: MockOrganizationID().id).organization;
    Map<String, dynamic> orgWithIDMap = organizationWithID.toMap;
    Organization newOrganization = Organization.fromMap(orgWithIDMap);
    expect(newOrganization == organizationWithID, true);

    expect(newOrganization != organization, true);
  }

  // VERIFY `canAddRemove`
  static void verifyCanAddRemove() {
    Organization org =
        MockOrganization(id: MockOrganizationID().id).organization;

    // TODO: Redo
    bool result = false;
    // final creator = Permissions.Creator;
    // result = org.canAddRemove(authorization: creator);
    expect(result, true);
    // final maintainer = Permissions.Maintainer;
    // result = org.canAddRemove(authorization: maintainer);
    // expect(result, true);
    // final reporter = Permissions.Reporter;
    // result = org.canAddRemove(authorization: reporter);
    // expect(result, false);
    // final viewer = Permissions.Viewer;
    // result = org.canAddRemove(authorization: viewer);
    // expect(result, false);

    final id = MockMemberID().id;
    final badID = MockMemberID(id: "bad ID").id;
    final nullID = null;
    result = org.canAddRemove(id: id);
    expect(result, true);
    result = org.canAddRemove(id: nullID);
    expect(result, false);
    result = org.canAddRemove(id: badID);
    expect(result, false);
  }

  // VERIFY `canEditRoles`
  static void verifyCanEditRoles() {
    Organization org =
        MockOrganization(id: MockOrganizationID().id).organization;

    // TODO: Redo
    bool result = false;
    // final creator = Permissions.Creator;
    // result = org.canEditRoles(authorization: creator);
    expect(result, true);
    // final maintainer = Permissions.Maintainer;
    // result = org.canEditRoles(authorization: maintainer);
    // expect(result, true);
    // final reporter = Permissions.Reporter;
    // result = org.canEditRoles(authorization: reporter);
    // expect(result, false);
    // final viewer = Permissions.Viewer;
    // result = org.canEditRoles(authorization: viewer);
    // expect(result, false);

    final id = MockMemberID().id;
    final badID = MockMemberID(id: "bad ID").id;
    final nullID = null;
    result = org.canEditRoles(id: id);
    expect(result, true);
    result = org.canEditRoles(id: nullID);
    expect(result, false);
    result = org.canEditRoles(id: badID);
    expect(result, false);
  }

  // VERIFY `canEdit`
  static void verifyCanEdit() {
    Organization org =
        MockOrganization(id: MockOrganizationID().id).organization;

    // TODO: Redo
    bool result = false;
    // final creator = Permissions.Creator;
    // result = org.canEdit(authorization: creator);
    expect(result, true);
    // final maintainer = Permissions.Maintainer;
    // result = org.canEdit(authorization: maintainer);
    // expect(result, false);
    // final reporter = Permissions.Reporter;
    // result = org.canEdit(authorization: reporter);
    // expect(result, false);
    // final viewer = Permissions.Viewer;
    // result = org.canEdit(authorization: viewer);
    // expect(result, false);

    final id = MockMemberID().id;
    final badID = MockMemberID(id: "bad ID").id;
    final nullID = null;
    result = org.canEdit(id: id);
    expect(result, true);
    result = org.canEdit(id: nullID);
    expect(result, false);
    result = org.canEdit(id: badID);
    expect(result, false);
  }
}

runOrganizationTests() {
  group("Organization", () {
    test("Organization name",
        OrganizationTests.shouldReturnValidNameWhenGivenName);
    test("equivalency", OrganizationTests.verifyEquivalencyOperator);
    test("Same Identity as", OrganizationTests.verifySameIdentityAs);
    test("verify id", OrganizationTests.verifyID);
    // TODO: CHeck Tests
    // test("verify mapping", OrganizationTests.verifyMapping);
    // test("verify canAddRemove", OrganizationTests.verifyCanAddRemove);
    // test("verify canEdit", OrganizationTests.verifyCanEdit);
    // test("verify canEditRoles", OrganizationTests.verifyCanEditRoles);
  });
}
