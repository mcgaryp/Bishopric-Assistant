import 'package:flutter_test/flutter_test.dart';
import 'package:models/models/organization.dart';
import 'package:models/shared/test.dart';

import '../../../mocks/organization/mock_organization_repository.dart';

///
/// all_organizations_use_case_test.dart
///
///
/// Created by Joshua Bee on 2/11/22
/// Copyright 2022 Joshua Bee. All rights reserved.
///

class AllOrganizationsUseCaseTest implements Test {
  // REPO FUNCTION CALLS
  static void verifyFunctionRepoCalls() async {
    MockOrganizationRepository orgRepo = MockOrganizationRepository();

    AllOrganizationsUseCase useCase = DefaultAllOrganizationsUseCase(orgRepo);

    await useCase.execute();

    expect(orgRepo.findFlag, false);
    expect(orgRepo.findAllFlag, true);
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
    expect(orgRepo.requestToJoinOrganizationFlag, false);
    expect(orgRepo.updateFlag, false);
  }

  // TODO: VERIFY PERMISSIONS
  static void verifyPermissions() async {
    // at the moment there is not a requirement for permissions to access all
    //    the organizations. Potentially requesting an account ID would be a
    //    good place to start though
  }

  // TODO: VERIFY RESULTS
  static void verifyResults() async {
    // at the moment there is not a way to verify streamed list
  }
}

runAllOrganizationsUseCaseTest() {
  group("All Organizations Use Case Test", () {
    test("Verify repo function calls",
        AllOrganizationsUseCaseTest.verifyFunctionRepoCalls);
    test("verify permissions", AllOrganizationsUseCaseTest.verifyPermissions);
    test("verify results", AllOrganizationsUseCaseTest.verifyResults);
  });
}
