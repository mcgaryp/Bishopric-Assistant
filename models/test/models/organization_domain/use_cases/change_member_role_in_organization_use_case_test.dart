import 'package:flutter_test/flutter_test.dart';
import 'package:models/models/organization.dart';
import 'package:models/shared/test.dart';

import '../../../mocks/organization/mock_member.dart';
import '../../../mocks/organization/mock_member_repository.dart';
import '../../../mocks/organization/mock_role.dart';

///
/// change_member_role_in_organization_use_case_test.dart
///
///
/// Created by Joshua Bee on 2/11/22
/// Copyright 2022 Joshua Bee. All rights reserved.
///

class ChangeMemberRoleInOrganizationUseCaseTest implements Test {
  // REPO FUNCTION CALLS
  // - Member Repo
  //   - find
  //   - findOrganization
  //   - update
  static void verifyFunctionRepoCalls() async {
    MockMemberRepository memberRepo = MockMemberRepository();
    ChangeMemberRoleInOrganizationUseCase useCase =
        DefaultChangeMemberRoleInOrganizationUseCase(memberRepo);

    await useCase.execute(
        accessorID: MockMemberID().id,
        memberID: MockMemberID().id,
        role: MockRole().role);

    expect(memberRepo.findFlag, true);
    expect(memberRepo.findAllFlag, false);
    expect(memberRepo.findAllStreamedFlag, false);
    expect(memberRepo.findAllWithAccountIDFlag, false);
    expect(memberRepo.findOrganizationFlag, true);
    expect(memberRepo.findStreamedFlag, false);
    expect(memberRepo.findWithAccountIDFlag, false);
    expect(memberRepo.insertFlag, false);
    expect(memberRepo.updateFlag, true);
    expect(memberRepo.removeFlag, false);
  }

  // VERIFY PERMISSIONS
  // if the accessor is not in the same organization as the member then not
  //    allowed. Use the `canEditRoles` from organization class
  static void verifyPermissions() async {
    // Currently not a way built to check that can edit roles has been called
  }

  // VERIFY RESULTS
  // - Return true without errors
  static void verifyResults() async {
    // expected
    MockMemberRepository memberRepo = MockMemberRepository();
    ChangeMemberRoleInOrganizationUseCase useCase =
        DefaultChangeMemberRoleInOrganizationUseCase(memberRepo);

    bool result = await useCase.execute(
        accessorID: MockMemberID().id,
        memberID: MockMemberID().id,
        role: MockRole().role);
    expect(result, true);
  }
}

runChangeMemberRoleInOrganizationUseCaseTest() {
  group("Change Member Role In Organization Use Case Test", () {
    test("Verify repo function calls",
        ChangeMemberRoleInOrganizationUseCaseTest.verifyFunctionRepoCalls);
    test("verify permissions",
        ChangeMemberRoleInOrganizationUseCaseTest.verifyPermissions);
    test("verify results",
        ChangeMemberRoleInOrganizationUseCaseTest.verifyResults);
  });
}
