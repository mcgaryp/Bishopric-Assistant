import 'package:flutter_test/flutter_test.dart';
import 'package:models/models/organization.dart';
import 'package:models/shared/test.dart';

import '../../../mocks/account/mock_account.dart';
import '../../../mocks/account/mock_account_repository.dart';
import '../../../mocks/organization/mock_member_repository.dart';
import '../../../mocks/organization/mock_organization_repository.dart';

///
/// create_organization_use_case_test.dart
///
///
/// Created by Joshua Bee on 2/11/22
/// Copyright 2022 Joshua Bee. All rights reserved.
///

class CreateOrganizationUseCaseTest implements Test {
  // REPO FUNCTION CALLS
  // - account repo
  //   - find
  // - member repo
  //   - insert
  //   - find
  // - organization
  //   - insert
  //   - findByName
  static void verifyFunctionRepoCalls() async {
    MockAccountRepository accountRepo = MockAccountRepository();
    MockOrganizationRepository orgRepo = MockOrganizationRepository();
    MockMemberRepository memberRepo = MockMemberRepository();
    CreateOrganizationUseCase useCase =
        DefaultCreateOrganizationUseCase(accountRepo, orgRepo, memberRepo);

    await useCase.execute(creatorId: MockAccountID().id, name: "name");

    expect(memberRepo.findFlag, false);
    expect(memberRepo.findAllFlag, false);
    expect(memberRepo.findAllStreamedFlag, false);
    expect(memberRepo.findAllWithAccountIDFlag, false);
    expect(memberRepo.findOrganizationFlag, false);
    expect(memberRepo.findStreamedFlag, false);
    expect(memberRepo.findWithAccountIDFlag, false);
    expect(memberRepo.insertFlag, true);
    expect(memberRepo.updateFlag, false);
    expect(memberRepo.removeFlag, false);

    expect(orgRepo.findFlag, false);
    expect(orgRepo.findAllFlag, false);
    expect(orgRepo.findAllRelationshipsFlag, false);
    expect(orgRepo.findAllRequestsFlag, false);
    expect(orgRepo.findAllRequestsStreamedFlag, false);
    expect(orgRepo.findByNameFlag, true);
    expect(orgRepo.findStreamedFlag, false);
    expect(orgRepo.insertFlag, true);
    expect(orgRepo.insertRelationshipFlag, true);
    expect(orgRepo.removeFlag, false);
    expect(orgRepo.removeRelationshipFlag, false);
    expect(orgRepo.removeRequestToJoinOrganizationFlag, false);
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
  static void verifyPermissions() async {
    // ensure that the user is an account holder this is done by passing in account ID
  }

  // TODO: VERIFY RESULTS
  static void verifyResults() async {
    // should return true when created
    // should throws false when organization or member(creator) was not created
  }
}

runCreateOrganizationUseCaseTest() {
  group("Create Organization Use Case Test", () {
    test("Verify repo function calls",
        CreateOrganizationUseCaseTest.verifyFunctionRepoCalls);
    test("verify permissions", CreateOrganizationUseCaseTest.verifyPermissions);
    test("verify results", CreateOrganizationUseCaseTest.verifyResults);
  });
}
