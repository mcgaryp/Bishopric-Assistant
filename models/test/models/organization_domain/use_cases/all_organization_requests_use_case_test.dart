import 'package:flutter_test/flutter_test.dart';
import 'package:models/models/organization.dart';
import 'package:models/shared/test.dart';

import '../../../mocks/organization/mock_organization.dart';
import '../../../mocks/organization/mock_organization_repository.dart';

///
/// all_organization_requests_use_case_test.dart
///
///
/// Created by Joshua Bee on 2/11/22
/// Copyright 2022 Joshua Bee. All rights reserved.
///

class AllOrganizationRequestsUseCaseTest implements Test {
  // REPO FUNCTION CALLS
  // - Organization Repo
  //   - find all requests streamed
  static void verifyFunctionRepoCalls() async {
    MockOrganizationRepository orgRepo = MockOrganizationRepository();

    AllOrganizationRequestsUseCase useCase =
        DefaultAllOrganizationRequestsUseCase(orgRepo);

    await useCase.execute(MockOrganizationID().id);

    expect(orgRepo.findFlag, false);
    expect(orgRepo.findAllFlag, false);
    expect(orgRepo.findAllRelationshipsFlag, false);
    expect(orgRepo.findAllRequestsFlag, false);
    expect(orgRepo.findAllRequestsStreamedFlag, true);
    expect(orgRepo.findByNameFlag, false);
    expect(orgRepo.findStreamedFlag, false);
    expect(orgRepo.insertFlag, false);
    expect(orgRepo.insertRelationshipFlag, false);
    expect(orgRepo.removeFlag, false);
    expect(orgRepo.removeRelationshipFlag, false);
    expect(orgRepo.removeRequestToJoinOrganizationFlag, false);
    expect(orgRepo.requestToJoinOrganizationFlag, false);
    expect(orgRepo.updateFlag, false);
  }

  // TODO: VERIFY PERMISSIONS
  static void verifyPermissions() async {
    // At the moment there are not permissions surrounding this use case
  }

  // TODO: VERIFY RESULTS
  static void verifyResults() async {
    // At the moment there is no way to check streamed items as a result and
    //    there are no errors to track
  }
}

runAllOrganizationRequestsUseCaseTest() {
  group("All Organization Requests Use Case Test", () {
    test("Verify repo function calls",
        AllOrganizationRequestsUseCaseTest.verifyFunctionRepoCalls);
    test("verify permissions",
        AllOrganizationRequestsUseCaseTest.verifyPermissions);
    test("verify results", AllOrganizationRequestsUseCaseTest.verifyResults);
  });
}
