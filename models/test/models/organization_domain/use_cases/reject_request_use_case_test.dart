import 'package:flutter_test/flutter_test.dart';
import 'package:models/models/organization.dart';
import 'package:models/shared/test.dart';

import '../../../mocks/organization/mock_join_request.dart';
import '../../../mocks/organization/mock_organization_repository.dart';

///
/// reject_request_use_case_test.dart
///
///
/// Created by Joshua Bee on 2/11/22
/// Copyright 2022 Joshua Bee. All rights reserved.
///

class RejectRequestUseCaseTest implements Test {
  // REPO FUNCTION CALLS
  static void verifyFunctionRepoCalls() async {
    MockOrganizationRepository orgRepo = MockOrganizationRepository();
    RejectRequestUseCase useCase = DefaultRejectRequestUseCase(orgRepo);

    await useCase.execute(MockJointRequest().request);

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
    expect(orgRepo.removeRequestToJoinOrganizationFlag, true);
    expect(orgRepo.requestToJoinOrganizationFlag, false);
    expect(orgRepo.updateFlag, false);
  }

  // TODO: VERIFY PERMISSIONS ?
  static void verifyPermissions() async {
    // verify that the user has the permission to add or reject members to group
  }

  // TODO: VERIFY RESULTS ?
  static void verifyResults() async {
    // should return true if successful
    // should throw error if failure
  }
}

runRejectRequestUseCaseTest() {
  group("Reject Request Use Case Test", () {
    test("Verify repo function calls",
        RejectRequestUseCaseTest.verifyFunctionRepoCalls);
    test("verify permissions", RejectRequestUseCaseTest.verifyPermissions);
    test("verify results", RejectRequestUseCaseTest.verifyResults);
  });
}
