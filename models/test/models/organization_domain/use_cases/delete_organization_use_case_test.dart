import 'package:flutter_test/flutter_test.dart';
import 'package:models/models/organization.dart';
import 'package:models/shared/test.dart';

import '../../../mocks/assignment/mock_assignment_repository.dart';
import '../../../mocks/event/mock_event_repo.dart';
import '../../../mocks/organization/mock_member.dart';
import '../../../mocks/organization/mock_member_repository.dart';
import '../../../mocks/organization/mock_organization.dart';
import '../../../mocks/organization/mock_organization_repository.dart';

///
/// delete_organization_use_case_test.dart
///
///
/// Created by Joshua Bee on 2/11/22
/// Copyright 2022 Joshua Bee. All rights reserved.
///

class DeleteOrganizationUseCaseTest implements Test {
  // TODO: REPO FUNCTION CALLS ?
  static void verifyFunctionRepoCalls() async {
    MockMemberRepository memberRepo = MockMemberRepository();
    MockOrganizationRepository orgRepo = MockOrganizationRepository();
    MockAssignmentRepository assignmentRepo = MockAssignmentRepository();
    MockEventRepository eventRepository = MockEventRepository();
    DeleteOrganizationUseCase useCase = DefaultDeleteOrganizationUseCase(
        orgRepo, memberRepo, assignmentRepo, eventRepository);
    await useCase.execute(
        creatorID: MockMemberID().id, organizationID: MockOrganizationID().id);

    expect(memberRepo.findFlag, true);
    expect(memberRepo.findAllFlag, true);
    expect(memberRepo.findAllStreamedFlag, false);
    expect(memberRepo.findAllWithAccountIDFlag, false);
    expect(memberRepo.findOrganizationFlag, false);
    expect(memberRepo.findStreamedFlag, false);
    expect(memberRepo.findWithAccountIDFlag, false);
    expect(memberRepo.insertFlag, false);
    expect(memberRepo.updateFlag, false);
    expect(memberRepo.removeFlag, true);

    expect(orgRepo.findFlag, true);
    expect(orgRepo.findAllFlag, false);
    expect(orgRepo.findAllRelationshipsFlag, true);
    expect(orgRepo.findAllRequestsFlag, true);
    expect(orgRepo.findAllRequestsStreamedFlag, false);
    expect(orgRepo.findByNameFlag, false);
    expect(orgRepo.findStreamedFlag, false);
    expect(orgRepo.insertFlag, false);
    expect(orgRepo.insertRelationshipFlag, false);
    expect(orgRepo.removeFlag, true);
    expect(orgRepo.removeRelationshipFlag, true);
    expect(orgRepo.removeRequestToJoinOrganizationFlag, true);
    expect(orgRepo.requestToJoinOrganizationFlag, false);
    expect(orgRepo.updateFlag, false);

    expect(assignmentRepo.findAllStreamedByOrganizationIDFlag, false);
    expect(assignmentRepo.findFlag, false);
    expect(assignmentRepo.findAllFlag, false);
    expect(assignmentRepo.findStreamFlag, false);
    expect(assignmentRepo.insertFlag, false);
    expect(assignmentRepo.removeFlag, false);
    expect(assignmentRepo.updateFlag, false);

    // TODO: Add Event expects
  }

  // TODO: VERIFY PERMISSIONS ?
  static void verifyPermissions() async {
    // Check to insure that the accessor is the creator of the organization
  }

  // TODO: VERIFY RESULTS ?
  static void verifyResults() async {
    // return true if successful
    // throw errors when fail
  }
}

runDeleteOrganizationUseCaseTest() {
  group("Delete Organization Use Case Test", () {
    test("Verify repo function calls",
        DeleteOrganizationUseCaseTest.verifyFunctionRepoCalls);
    test("verify permissions", DeleteOrganizationUseCaseTest.verifyPermissions);
    test("verify results", DeleteOrganizationUseCaseTest.verifyResults);
  });
}
