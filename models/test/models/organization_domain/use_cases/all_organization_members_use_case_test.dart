import 'package:flutter_test/flutter_test.dart';
import 'package:models/models/organization.dart';
import 'package:models/shared/test.dart';

import '../../../mocks/organization/mock_member_repository.dart';
import '../../../mocks/organization/mock_organization.dart';

///
/// all_organization_members_use_case_test.dart
///
///
/// Created by Joshua Bee on 2/11/22
/// Copyright 2022 Joshua Bee. All rights reserved.
///

class AllOrganizationMembersUseCaseTest implements Test {
  // REPO FUNCTION CALLS
  // - Member Repo
  //   - findAllStreamed
  static void verifyFunctionRepoCalls() async {
    MockMemberRepository memberRepo = MockMemberRepository();

    AllOrganizationMembersUseCase useCase =
        DefaultAllOrganizationMembersUseCase(memberRepo);
    await useCase.execute(MockOrganizationID().id);

    expect(memberRepo.findFlag, false);
    expect(memberRepo.findAllFlag, false);
    expect(memberRepo.findAllStreamedFlag, true);
    expect(memberRepo.findAllWithAccountIDFlag, false);
    expect(memberRepo.findOrganizationFlag, false);
    expect(memberRepo.findStreamedFlag, false);
    expect(memberRepo.findWithAccountIDFlag, false);
    expect(memberRepo.insertFlag, false);
    expect(memberRepo.updateFlag, false);
    expect(memberRepo.removeFlag, false);
  }

  // TODO: VERIFY PERMISSIONS
  // - ensure that the accessor is a member of the organization
  static void verifyPermissions() async {
    // At the moment this does not currently supported but can be implemented
  }

  // TODO: VERIFY RESULTS
  // - returns a streamed list
  static void verifyResults() async {
    // At the moment not sure how this process can be tested with a stream

    // MockMemberRepository memberRepo = MockMemberRepository();
    // AllOrganizationMembersUseCase useCase =
    // DefaultAllOrganizationMembersUseCase(memberRepo);
    // Stream<List<Stream<Member>>> stream = await useCase.execute(MockOrganizationID().id);
  }
}

runAllOrganizationMembersUseCaseTest() {
  group("All Organization Members Use Case Test", () {
    test("Verify repo function calls",
        AllOrganizationMembersUseCaseTest.verifyFunctionRepoCalls);
    test("verify permissions",
        AllOrganizationMembersUseCaseTest.verifyPermissions);
    test("verify results", AllOrganizationMembersUseCaseTest.verifyResults);
  });
}
