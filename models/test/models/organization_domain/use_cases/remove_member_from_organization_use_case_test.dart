import 'package:flutter_test/flutter_test.dart';
import 'package:models/models/organization.dart';
import 'package:models/shared/test.dart';

import '../../../mocks/organization/mock_member.dart';
import '../../../mocks/organization/mock_member_repository.dart';

///
/// remove_member_from_organization_use_case_test.dart
///
///
/// Created by Joshua Bee on 2/11/22
/// Copyright 2022 Joshua Bee. All rights reserved.
///

class RemoveMemberFromOrganizationUseCaseTest implements Test {
  // TODO: REPO FUNCTION CALLS ?
  static void verifyFunctionRepoCalls() async {
    MockMemberRepository memberRepo = MockMemberRepository();
    RemoveMemberFromOrganizationUseCase useCase =
        DefaultRemoveMemberFromOrganizationUseCase(memberRepo);

    await useCase.execute(
        accessorId: MockMemberID().id, memberID: MockMemberID().id);

    expect(memberRepo.findFlag, true);
    expect(memberRepo.findAllFlag, false);
    expect(memberRepo.findAllStreamedFlag, false);
    expect(memberRepo.findAllWithAccountIDFlag, false);
    expect(memberRepo.findOrganizationFlag, true);
    expect(memberRepo.findStreamedFlag, false);
    expect(memberRepo.findWithAccountIDFlag, false);
    expect(memberRepo.insertFlag, false);
    expect(memberRepo.updateFlag, false);
    expect(memberRepo.removeFlag, true);
  }

  // TODO: VERIFY PERMISSIONS ?
  static void verifyPermissions() async {
    // verify that the user removing the member has the proper authority to remove them
  }

  // TODO: VERIFY RESULTS ?
  static void verifyResults() async {
    // returns true if successful
    // throws errors on failure
  }
}

runRemoveMemberFromOrganizationUseCaseTest() {
  group("Remove Member From Organization Use Case Test", () {
    // TODO: Modify Test
    // test("Verify repo function calls",
    //     RemoveMemberFromOrganizationUseCaseTest.verifyFunctionRepoCalls);
    test("verify permissions",
        RemoveMemberFromOrganizationUseCaseTest.verifyPermissions);
    test("verify results",
        RemoveMemberFromOrganizationUseCaseTest.verifyResults);
  });
}
