import 'package:flutter_test/flutter_test.dart';
import 'package:models/models/assignment.dart';

import '../../../mocks/assignment/mock_assignment_repository.dart';
import '../../../mocks/organization/mock_member_repository.dart';

///
/// mark_assignment_complete_use_case_test.dart
///
///
/// Created by Joshua Bee on 2/7/22
/// Copyright 2022 Joshua Bee. All rights reserved.
///

class MarkAssignmentCompleteUseCaseTest {
  // REPO FUNCTION CALLS
  // - Uses Member Repo
  //   - calls find
  // - Uses Assignment Repo
  //   - calls find
  //   - calls update
  static void verifyFunctionRepoCalls() async {
    MockMemberRepository memberRepository = MockMemberRepository();
    MockAssignmentRepository assignmentRepository = MockAssignmentRepository();
    MarkAssignmentCompleteUseCase useCase =
        DefaultMarkAssignmentCompleteUseCase(
            memberRepository, assignmentRepository);
    await useCase.execute(
        memberID: memberRepository.member.id,
        assignmentID: assignmentRepository.assignment.id);

    /// Member Repository checks
    expect(memberRepository.findFlag, true);
    expect(memberRepository.findAllFlag, false);
    expect(memberRepository.findAllStreamedFlag, false);
    expect(memberRepository.findAllWithAccountIDFlag, false);
    expect(memberRepository.findOrganizationFlag, false);
    expect(memberRepository.findStreamedFlag, false);
    expect(memberRepository.findWithAccountIDFlag, false);
    expect(memberRepository.insertFlag, false);
    expect(memberRepository.removeFlag, false);
    expect(memberRepository.updateFlag, false);

    /// Assignment Repository checks
    expect(assignmentRepository.findFlag, true);
    expect(assignmentRepository.findAllFlag, false);
    expect(assignmentRepository.findAllStreamedByOrganizationIDFlag, false);
    expect(assignmentRepository.findStreamFlag, false);
    expect(assignmentRepository.insertFlag, false);
    expect(assignmentRepository.removeFlag, false);
    expect(assignmentRepository.updateFlag, true);
  }

  // CHECK RESULTS
  // - Returns true or false or errors
  static void verifyResults() async {
    MockMemberRepository memberRepository = MockMemberRepository();
    MockAssignmentRepository assignmentRepository = MockAssignmentRepository();
    MarkAssignmentCompleteUseCase useCase =
        DefaultMarkAssignmentCompleteUseCase(
            memberRepository, assignmentRepository);
    bool results = await useCase.execute(
        memberID: memberRepository.member.id,
        assignmentID: assignmentRepository.assignment.id);
    expect(results, true);
  }

  // CHECK PERMISSIONS
  // - calls canComplete from Assignment
  ///TODO verify permissions ?
  static void verifyPermissions() async {
    //who is authorized to mark it
  }
}

runMarkAssignmentCompleteUseCaseTest() {
  group("Mark Assignment Complete Use Case Test", () {
    test("Verify repo function calls",
        MarkAssignmentCompleteUseCaseTest.verifyFunctionRepoCalls);
    test("verify permissions",
        MarkAssignmentCompleteUseCaseTest.verifyPermissions);
    test("verify results", MarkAssignmentCompleteUseCaseTest.verifyResults);
  });
}
