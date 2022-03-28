import 'package:flutter_test/flutter_test.dart';
import 'package:models/models/organization.dart';
import 'package:models/shared/test.dart';

import '../../../mocks/organization/mock_join_request.dart';
import '../../../mocks/organization/mock_join_request_repository.dart';

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
    MockJoinRequestRepository requestRepo = MockJoinRequestRepository();
    RejectRequestUseCase useCase = DefaultRejectRequestUseCase(requestRepo);

    await useCase.execute(MockJoinRequest().request.id);

    expect(false, "Redo this test");
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
    // expect(requestRepo.removeRequestToJoinOrganizationFlag, true);
    // expect(requestRepo.requestToJoinOrganizationFlag, false);
    // expect(requestRepo.updateFlag, false);
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
    // TODO: Modify Test
    // test("Verify repo function calls",
    //     RejectRequestUseCaseTest.verifyFunctionRepoCalls);
    test("verify permissions", RejectRequestUseCaseTest.verifyPermissions);
    test("verify results", RejectRequestUseCaseTest.verifyResults);
  });
}
