import 'package:flutter_test/flutter_test.dart';
import 'package:models/models/organization.dart';
import 'package:models/shared/exceptions/exceptions.dart';
import 'package:models/shared/test.dart';

import '../../../mocks/organization/mock_member.dart';
import '../../../mocks/organization/mock_member_repository.dart';
import '../../../mocks/organization/mock_organization.dart';
import '../../../mocks/organization/mock_organization_repository.dart';

///
/// change_organization_name_use_case_test.dart
///
///
/// Created by Joshua Bee on 2/11/22
/// Copyright 2022 Joshua Bee. All rights reserved.
///

class ChangeOrganizationNameUseCaseTest implements Test {
  // REPO FUNCTION CALLS
  // - Organization Repo
  //   - find
  //   - update
  // - Member Repo
  //   - find
  static void verifyFunctionRepoCalls() async {
    MockMemberRepository memberRepo = MockMemberRepository();
    MockOrganizationRepository orgRepo = MockOrganizationRepository();
    ChangeOrganizationNameUseCase useCase =
        DefaultChangeOrganizationNameUseCase(orgRepo, memberRepo);

    await useCase.execute(accessorId: MockMemberID().id, name: "New Org name");

    expect(memberRepo.findFlag, true);
    expect(memberRepo.findAllFlag, false);
    expect(memberRepo.findAllStreamedFlag, false);
    expect(memberRepo.findAllWithAccountIDFlag, false);
    expect(memberRepo.findOrganizationFlag, true);
    expect(memberRepo.findStreamedFlag, false);
    expect(memberRepo.findWithAccountIDFlag, false);
    expect(memberRepo.insertFlag, false);
    expect(memberRepo.updateFlag, false);
    expect(memberRepo.removeFlag, false);

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
    expect(orgRepo.requestToJoinOrganizationFlag, false);
    expect(orgRepo.updateFlag, true);
  }

  // TODO VERIFY PERMISSIONS
  // - verify organization canEdit is called
  static void verifyPermissions() async {
    // At the moment there is no way to check this
  }

  // TODO: VERIFY RESULTS
  // Failed to Save Error, because of same name or just failed to save
  // Member not found
  // Organization not found
  // Returns true when successful
  static void verifyResults() async {
    // expected result
    MockOrganizationRepository orgRepo = MockOrganizationRepository();
    MockMemberRepository memberRepo = MockMemberRepository();

    ChangeOrganizationNameUseCase useCase =
        DefaultChangeOrganizationNameUseCase(orgRepo, memberRepo);

    bool result = await useCase.execute(
        accessorId: MockMemberID().id, name: "New Org name");

    expect(result, true);

    // fails to update name error
    try {
      orgRepo = MockOrganizationRepository(shouldSucceed: false);
      memberRepo = MockMemberRepository();

      useCase = DefaultChangeOrganizationNameUseCase(orgRepo, memberRepo);
      await useCase.execute(
          accessorId: MockMemberID().id, name: "New Org name");
      Test.fallthrough(notes: "Fails to notify of change name failed");
    } catch (error) {
      expect(
          error.toString(),
          FailedToSaveError(reason: "Organization name failed to update")
              .toString());
    }

    // same organization name as the last name
    try {
      orgRepo = MockOrganizationRepository();
      memberRepo = MockMemberRepository();

      useCase = DefaultChangeOrganizationNameUseCase(orgRepo, memberRepo);
      await useCase.execute(
          accessorId: MockMemberID().id,
          name: MockOrganization().organization.name);
      Test.fallthrough(notes: "Fails to notify of same name");
    } catch (error) {
      expect(
          error.toString(),
          FailedToSaveError(
                  reason: "New organization name cannot be same as previous")
              .toString());
    }

    // bad member id
    try {
      orgRepo = MockOrganizationRepository();
      memberRepo = MockMemberRepository(
          organization: MockOrganization(
                  creator: MockMember(id: MockMemberID(id: "bad id").id).member)
              .organization);

      useCase = DefaultChangeOrganizationNameUseCase(orgRepo, memberRepo);
      await useCase.execute(
          accessorId: MockMemberID().id, name: "New Org name");
      Test.fallthrough(notes: "Fails to notify organization not found");
    } catch (error) {
      expect(error.toString(), OrganizationNotFoundError().toString());
    }

    // bad organization
    try {
      orgRepo = MockOrganizationRepository();
      memberRepo = MockMemberRepository();

      useCase = DefaultChangeOrganizationNameUseCase(orgRepo, memberRepo);
      await useCase.execute(
          accessorId: MockMemberID(id: "bad member ID").id,
          name: "New Org name");
      Test.fallthrough(notes: "Fails to notify member not found");
    } catch (error) {
      expect(error.toString(), MemberNotFoundError().toString());
    }
  }
}

runChangeOrganizationNameUseCaseTest() {
  group("Change Organization Name Use Case Test", () {
    test("Verify repo function calls",
        ChangeOrganizationNameUseCaseTest.verifyFunctionRepoCalls);
    test("verify permissions",
        ChangeOrganizationNameUseCaseTest.verifyPermissions);
    test("verify results", ChangeOrganizationNameUseCaseTest.verifyResults);
  });
}
