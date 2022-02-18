import 'package:flutter_test/flutter_test.dart';
import 'package:models/models/organization.dart';
import 'package:models/shared/test.dart';

import '../../../mocks/account/mock_account.dart';
import '../../../mocks/organization/mock_member_repository.dart';

///
/// has_associated_organization_use_case_test.dart
///
///
/// Created by Joshua Bee on 2/11/22
/// Copyright 2022 Joshua Bee. All rights reserved.
///

class HasAssociatedOrganizationUseCaseTest implements Test {
  // REPO FUNCTION CALLS
  static void verifyFunctionRepoCalls() async {
    MockMemberRepository memberRepo = MockMemberRepository();
    HasAssociatedOrganizationUseCase useCase =
        DefaultHasAssociatedOrganizationUseCase(memberRepo);
    await useCase.execute(accountID: MockAccountID().id);

    expect(memberRepo.findFlag, false);
    expect(memberRepo.findAllFlag, false);
    expect(memberRepo.findAllStreamedFlag, false);
    expect(memberRepo.findAllWithAccountIDFlag, true);
    expect(memberRepo.findOrganizationFlag, true);
    expect(memberRepo.findStreamedFlag, false);
    expect(memberRepo.findWithAccountIDFlag, false);
    expect(memberRepo.insertFlag, false);
    expect(memberRepo.updateFlag, false);
    expect(memberRepo.removeFlag, false);
  }

  // TODO: VERIFY PERMISSIONS
  static void verifyPermissions() async {
    // ensure that the user has an account
  }

  // TODO: VERIFY RESULTS ?
  static void verifyResults() async {
    // returns true if it does or false if it does not
  }
}

runHasAssociatedOrganizationUseCaseTest() {
  group("Has Associated Organization Use Case Test", () {
    test("Verify repo function calls",
        HasAssociatedOrganizationUseCaseTest.verifyFunctionRepoCalls);
    test("verify permissions",
        HasAssociatedOrganizationUseCaseTest.verifyPermissions);
    test("verify results", HasAssociatedOrganizationUseCaseTest.verifyResults);
  });
}
