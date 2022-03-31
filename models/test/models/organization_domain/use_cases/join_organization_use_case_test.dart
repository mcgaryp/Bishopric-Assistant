import 'package:flutter_test/flutter_test.dart';
import 'package:models/models/organization.dart';
import 'package:models/shared/test.dart';

import '../../../mocks/account/mock_account.dart';
import '../../../mocks/organization/mock_join_request_repository.dart';
import '../../../mocks/organization/mock_organization.dart';

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
    MockJoinRequestRepository requestRepo = MockJoinRequestRepository();

    JoinOrganizationUseCase useCase =
        DefaultJoinOrganizationUseCase(requestRepo);

    await useCase.execute(
        accountID: MockAccountID().id, organizationID: MockOrganizationID().id);

    expect(false, "redo this section");
    // expect(requestRepo.findFlag, false);
    // expect(requestRepo.findAllFlag, false);
    // expect(requestRepo.findAllRelationshipsFlag, false);
    // expect(requestRepo.findAllRequestsFlag, false);
    // expect(requestRepo.findAllRequestsStreamedFlag, false);
    // expect(requestRepo.findByNameFlag, false);
    // expect(requestRepo.findStreamedFlag, false);
    // expect(requestRepo.insertFlag, false);
    // expect(requestRepo.insertRelationshipFlag, false);
    // expect(requestRepo.removeFlag, false);
    // expect(requestRepo.removeRelationshipFlag, false);
    // expect(requestRepo.removeRequestToJoinOrganizationFlag, false);
    // expect(requestRepo.requestToJoinOrganizationFlag, true);
    // expect(requestRepo.updateFlag, false);
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
    // TODO: Modify Test
    // test("Verify repo function calls",
    //     JoinOrganizationUseCaseTest.verifyFunctionRepoCalls);
    test("verify permissions", JoinOrganizationUseCaseTest.verifyPermissions);
    test("verify results", JoinOrganizationUseCaseTest.verifyResults);
  });
}
