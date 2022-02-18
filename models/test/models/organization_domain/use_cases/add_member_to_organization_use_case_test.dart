import 'package:flutter_test/flutter_test.dart';
import 'package:models/models/organization.dart';
import 'package:models/shared/exceptions/exceptions.dart';
import 'package:models/shared/test.dart';

import '../../../mocks/account/mock_account.dart';
import '../../../mocks/account/mock_account_repository.dart';
import '../../../mocks/organization/mock_join_request.dart';
import '../../../mocks/organization/mock_member.dart';
import '../../../mocks/organization/mock_member_repository.dart';
import '../../../mocks/organization/mock_organization.dart';
import '../../../mocks/organization/mock_organization_repository.dart';
import '../../../mocks/organization/mock_role.dart';

///
/// add_member_to_organization_use_case_test.dart
///
///
/// Created by Joshua Bee on 2/11/22
/// Copyright 2022 Joshua Bee. All rights reserved.
///

class AddMemberToOrganizationUseCaseTest implements Test {
  // REPO FUNCTION CALLS
  // TODO: Rework without relationships
  // - Member repo
  //   - calls find
  //   - calls insert
  // - Organization repo
  //   - calls find
  //   - calls update
  // - Account repo
  //   - calls find
  static void verifyFunctionRepoCalls() async {
    MockMemberRepository memberRepo = MockMemberRepository();
    MockOrganizationRepository orgRepo = MockOrganizationRepository();
    MockAccountRepository accountRepo = MockAccountRepository();

    DefaultAddMemberToOrganizationUseCase useCase =
        DefaultAddMemberToOrganizationUseCase(accountRepo, orgRepo, memberRepo);
    await useCase.execute(
      accessorId: MockMemberID().id,
      request: MockJointRequest().request,
      role: MockRole().role,
    );

    expect(memberRepo.findFlag, true);
    expect(memberRepo.findAllFlag, false);
    expect(memberRepo.findAllStreamedFlag, false);
    expect(memberRepo.findAllWithAccountIDFlag, false);
    expect(memberRepo.findOrganizationFlag, false);
    expect(memberRepo.findStreamedFlag, false);
    expect(memberRepo.findWithAccountIDFlag, false);
    expect(memberRepo.insertFlag, true);
    expect(memberRepo.updateFlag, false);
    expect(memberRepo.removeFlag, false);

    expect(orgRepo.findFlag, true);
    expect(orgRepo.findAllFlag, false);
    expect(orgRepo.findAllRelationshipsFlag, false);
    expect(orgRepo.findAllRequestsFlag, false);
    expect(orgRepo.findAllRequestsStreamedFlag, false);
    expect(orgRepo.findByNameFlag, false);
    expect(orgRepo.findStreamedFlag, false);
    expect(orgRepo.insertFlag, false);
    expect(orgRepo.insertRelationshipFlag, true);
    expect(orgRepo.removeFlag, false);
    expect(orgRepo.removeRelationshipFlag, false);
    expect(orgRepo.removeRequestToJoinOrganizationFlag, true);
    expect(orgRepo.requestToJoinOrganizationFlag, false);
    expect(orgRepo.updateFlag, false);

    expect(accountRepo.activateFlag, false);
    expect(accountRepo.findFlag, true);
    expect(accountRepo.findByEmailFlag, false);
    expect(accountRepo.findByPhoneFlag, false);
    expect(accountRepo.findByUsernameFlag, false);
    expect(accountRepo.findStreamedFlag, false);
    expect(accountRepo.insertFlag, false);
    expect(accountRepo.loginFlag, false);
    expect(accountRepo.logoutFlag, false);
    expect(accountRepo.removeFlag, false);
    expect(accountRepo.updateFlag, false);
  }

  // VERIFY PERMISSIONS
  // - Accessor must have the permissions of a maintainer, check that the
  //    function uses the organization function, `canAddRemove`
  static void verifyPermissions() async {
    // With Creator
    MockMemberRepository memberRepo = MockMemberRepository();
    MockOrganizationRepository orgRepo = MockOrganizationRepository();
    MockAccountRepository accountRepo = MockAccountRepository();
    DefaultAddMemberToOrganizationUseCase useCase =
        DefaultAddMemberToOrganizationUseCase(accountRepo, orgRepo, memberRepo);

    try {
      await useCase.execute(
        accessorId: MockMemberID().id,
        request: MockJointRequest().request,
        role: MockRole().role,
      );
    } catch (error) {
      if (kDebugMode) print(error);
      Test.fallthrough(
          notes: "Failed to let creator add a member to organization");
    }

    // With Maintainer
    memberRepo = MockMemberRepository(
        member: MockMember(
                id: MockMemberID(id: "I'm not the creator").id,
                role: MockRole(permissions: Permissions.Maintainer).role)
            .member);
    useCase =
        DefaultAddMemberToOrganizationUseCase(accountRepo, orgRepo, memberRepo);

    try {
      await useCase.execute(
        accessorId: MockMemberID(id: "I'm not the creator").id,
        request: MockJointRequest().request,
        role: MockRole().role,
      );
    } catch (error) {
      if (kDebugMode) print(error);
      Test.fallthrough(
          notes: "Failed to let maintainer add a member to organization");
    }

    // With Viewer
    memberRepo = MockMemberRepository(
        member: MockMember(
                id: MockMemberID(id: "I'm not the creator").id,
                role: MockRole(permissions: Permissions.Viewer).role)
            .member);
    useCase =
        DefaultAddMemberToOrganizationUseCase(accountRepo, orgRepo, memberRepo);

    try {
      await useCase.execute(
        accessorId: MockMemberID(id: "I'm not the creator").id,
        request: MockJointRequest().request,
        role: MockRole().role,
      );
      Test.fallthrough(
          notes: "Failed to not permit Viewer to add a member to organization");
    } catch (error) {
      expect(
          error.toString(),
          PermissionDeniedError(
                  reason: "Maintainer permissions required to Add "
                      "Members to Organization")
              .toString());
    }

    // With Reporter
    memberRepo = MockMemberRepository(
        member: MockMember(
                id: MockMemberID(id: "I'm not the creator").id,
                role: MockRole(permissions: Permissions.Reporter).role)
            .member);
    useCase =
        DefaultAddMemberToOrganizationUseCase(accountRepo, orgRepo, memberRepo);

    try {
      await useCase.execute(
        accessorId: MockMemberID(id: "I'm not the creator").id,
        request: MockJointRequest().request,
        role: MockRole().role,
      );
      Test.fallthrough(
          notes: "Failed to not permit Reporter to add a member to "
              "organization");
    } catch (error) {
      expect(
          error.toString(),
          PermissionDeniedError(
                  reason: "Maintainer permissions required to "
                      "Add Members to Organization")
              .toString());
    }
  }

  // VERIFY RESULTS
  // Throw error when account, organization, or accessing member does not exist
  // Throw error when member failed to save to the organization
  // Expects a true if all goes well
  static void verifyResults() async {
    // account does not exist
    MockOrganizationRepository orgRepo = MockOrganizationRepository();
    MockAccountRepository accountRepo = MockAccountRepository();
    MockMemberRepository memberRepo = MockMemberRepository();
    DefaultAddMemberToOrganizationUseCase useCase =
        DefaultAddMemberToOrganizationUseCase(accountRepo, orgRepo, memberRepo);

    bool result = await useCase.execute(
        accessorId: MockMemberID().id,
        request: MockJointRequest().request,
        role: MockRole().role);
    expect(result, true);

    try {
      MockOrganizationRepository orgRepo = MockOrganizationRepository();
      MockAccountRepository accountRepo = MockAccountRepository();
      MockMemberRepository memberRepo = MockMemberRepository();
      accountRepo = MockAccountRepository(
          account: MockAccount(id: MockAccountID(id: "different").id).account);

      useCase = DefaultAddMemberToOrganizationUseCase(
          accountRepo, orgRepo, memberRepo);

      await useCase.execute(
          accessorId: MockMemberID().id,
          request: MockJointRequest().request,
          role: MockRole().role);

      Test.fallthrough(notes: "Failed to notify that account was not found");
    } catch (error) {
      expect(error.toString(), AccountNotFoundError().toString());
    }

    // organization does not exist
    try {
      MockOrganizationRepository orgRepo = MockOrganizationRepository();
      MockAccountRepository accountRepo = MockAccountRepository();
      MockMemberRepository memberRepo = MockMemberRepository();
      orgRepo = MockOrganizationRepository(
          organization:
              MockOrganization(id: MockOrganizationID(id: "different").id)
                  .organization);

      useCase = DefaultAddMemberToOrganizationUseCase(
          accountRepo, orgRepo, memberRepo);

      await useCase.execute(
          accessorId: MockMemberID().id,
          request: MockJointRequest().request,
          role: MockRole().role);

      Test.fallthrough(
          notes: "Failed to notify that organization was not found");
    } catch (error) {
      expect(error.toString(), OrganizationNotFoundError().toString());
    }

    // Accessing member does not exist
    try {
      MockOrganizationRepository orgRepo = MockOrganizationRepository();
      MockAccountRepository accountRepo = MockAccountRepository();
      MockMemberRepository memberRepo =
          MockMemberRepository(shouldSucceed: false);
      memberRepo = MockMemberRepository(
          member: MockMember(id: MockMemberID(id: "different").id).member);

      useCase = DefaultAddMemberToOrganizationUseCase(
          accountRepo, orgRepo, memberRepo);

      await useCase.execute(
          accessorId: MockMemberID().id,
          request: MockJointRequest().request,
          role: MockRole().role);

      Test.fallthrough(
          notes: "Failed to notify that accessing member was not found");
    } catch (error) {
      expect(error.toString(), MemberNotFoundError().toString());
    }

    // failed to save member
    try {
      MockOrganizationRepository orgRepo = MockOrganizationRepository();
      MockAccountRepository accountRepo = MockAccountRepository();
      MockMemberRepository memberRepo =
          MockMemberRepository(shouldSucceed: false);

      useCase = DefaultAddMemberToOrganizationUseCase(
          accountRepo, orgRepo, memberRepo);

      await useCase.execute(
          accessorId: MockMemberID().id,
          request: MockJointRequest().request,
          role: MockRole().role);

      Test.fallthrough(notes: "Failed to notify that member was not saved");
    } catch (error) {
      expect(error.toString(),
          FailedToSaveError(reason: "Member to Organization").toString());
    }
  }
}

runAddMemberToOrganizationUseCaseTest() {
  group("Add Member To Organization Use Case Test", () {
    test("Verify repo function calls",
        AddMemberToOrganizationUseCaseTest.verifyFunctionRepoCalls);
    test("verify permissions",
        AddMemberToOrganizationUseCaseTest.verifyPermissions);
    test("verify results", AddMemberToOrganizationUseCaseTest.verifyResults);
  });
}
