import 'package:flutter_test/flutter_test.dart';
import 'package:models/models/organization.dart';
import 'package:models/shared/test.dart';

import '../../../mocks/account/mock_account.dart';
import '../../../mocks/organization/mock_organization.dart';
import '../../../mocks/organization/mock_organization_repository.dart';

///
/// join_organization_use_case_test.dart
///
///
/// Created by Joshua Bee on 2/11/22
/// Copyright 2022 Joshua Bee. All rights reserved.
///

class JoinOrganizationUseCaseTest implements Test {
  // REPO FUNCTION CALLS
  static void verifyFunctionRepoCalls() async {
    MockOrganizationRepository orgRepo = MockOrganizationRepository();
    JoinOrganizationUseCase useCase = DefaultJoinOrganizationUseCase(orgRepo);

    await useCase.execute(
        accountID: MockAccountID().id, organizationID: MockOrganizationID().id);

    expect(orgRepo.findFlag, false);
    expect(orgRepo.findAllFlag, false);
    expect(orgRepo.findAllRelationshipsFlag, false);
    expect(orgRepo.findAllRequestsFlag, false);
    expect(orgRepo.findAllRequestsStreamedFlag, false);
    expect(orgRepo.findByNameFlag, false);
    expect(orgRepo.findStreamedFlag, false);
    expect(orgRepo.insertFlag, false);
    expect(orgRepo.insertRelationshipFlag, false);
    expect(orgRepo.removeFlag, false);
    expect(orgRepo.removeRelationshipFlag, false);
    expect(orgRepo.removeRequestToJoinOrganizationFlag, false);
    expect(orgRepo.requestToJoinOrganizationFlag, true);
    expect(orgRepo.updateFlag, false);
  }

  // TODO: VERIFY PERMISSIONS
  static void verifyPermissions() async {
    // Verify that the user has an account and the organization exists
    // verify that the user has not requested more than once to join this organization
  }

  // TODO: VERIFY RESULTS
  static void verifyResults() async {
    // should return true if successful
    // throws an error if fails
  }
}

runJoinOrganizationUseCaseTest() {
  group("Join Organization Use Case Test", () {
    test("Verify repo function calls",
        JoinOrganizationUseCaseTest.verifyFunctionRepoCalls);
    test("verify permissions", JoinOrganizationUseCaseTest.verifyPermissions);
    test("verify results", JoinOrganizationUseCaseTest.verifyResults);
  });
}
