import 'package:flutter_test/flutter_test.dart';
import 'package:models/models/assignment.dart';
import 'package:models/models/organization_domain/organization_id.dart';
import 'package:models/shared/test.dart';

import '../../../mocks/assignment/mock_assignee.dart';
import '../../../mocks/organization/mock_member_repository.dart';
import '../../../mocks/organization/mock_organization.dart';

///
/// all_assignees_use_case_test.dart
///
///
/// Created by Porter McGary on 2/11/22
/// Copyright 2022 Porter McGary. All rights reserved.
///

class AllAssigneesUseCaseTests implements Test {
  // Tests that should be run
  // REPO FUNCTION CALL TEST
  // - call findAll from member repo
  static void verifyFunctionRepoCalls() async {
    OrganizationID organizationID = MockOrganizationID().id;
    MockMemberRepository memberRepository = MockMemberRepository();
    AllAssigneesUseCase useCase = DefaultAllAssigneesUseCase(memberRepository);
    await useCase.execute(organizationID);

    expect(memberRepository.findFlag, false);
    expect(memberRepository.findOrganizationFlag, false);
    expect(memberRepository.findAllFlag, true);
    expect(memberRepository.findAllStreamedFlag, false);
    expect(memberRepository.findAllWithAccountIDFlag, false);
    expect(memberRepository.findStreamedFlag, false);
    expect(memberRepository.insertFlag, false);
    expect(memberRepository.removeFlag, false);
    expect(memberRepository.updateFlag, false);
  }

  // TODO: VERIFY PERMISSIONS ?
  static void verifyPermissions() async {
    // could verify that the user can create assignments by making sure they
    // are a member of the right organization maybe using their credentials
  }

  // return a list of Members converted to assignees
  static void verifyResults() async {
    OrganizationID organizationID = MockOrganizationID().id;
    MockMemberRepository memberRepository = MockMemberRepository();
    AllAssigneesUseCase useCase = DefaultAllAssigneesUseCase(memberRepository);
    List<Assignee> result = await useCase.execute(organizationID);
    expect(result[0], MockAssignee().assignee);
  }
}

runAllAssigneesUseCaseTests() {
  group("All Assignees Use Case Tests", () {
    test("Verify repo function calls",
        AllAssigneesUseCaseTests.verifyFunctionRepoCalls);
    test("verify permissions", AllAssigneesUseCaseTests.verifyPermissions);
    test("verify results", AllAssigneesUseCaseTests.verifyResults);
  });
}
