import 'package:flutter_test/flutter_test.dart';
import 'package:models/models/assignment.dart';
import 'package:models/shared/test.dart';

import '../../../mocks/assignment/mock_assignment_repository.dart';
import '../../../mocks/organization/mock_member_repository.dart';

///
/// mark_assignment_incomplete_use_case_test.dart
///
///
/// Created by Joshua Bee on 2/7/22
/// Copyright 2022 Joshua Bee. All rights reserved.
///

class MarkAssignmentIncompleteUseCaseTest implements Test {
  // REPO FUNCTION CALLS
  // - Uses Member Repo
  //   - calls find
  // - Uses Assignment Repo
  //   - calls find
  //   - calls update
  static void givenValidArgsCallsProperFunctions() async {
    MockMemberRepository memberRepository = MockMemberRepository();
    MockAssignmentRepository assignmentRepository = MockAssignmentRepository();

    MarkAssignmentIncompleteUseCase useCase =
        DefaultMarkAssignmentIncompleteUseCase(
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

    MarkAssignmentIncompleteUseCase useCase =
        DefaultMarkAssignmentIncompleteUseCase(
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
    //note above
  }

// Calls the find from member repo
// Checks permission level of the member
// Calls incomplete() from assignment
// ensure that the assignment was properly completed and boolean is false
// Checks that update was called from assignment repo
}

runMarkAssignmentIncompleteUseCaseTest() {
  group("Mark Assignment Incomplete Use Case Test", () {
    test("Verify repo function calls",
        MarkAssignmentIncompleteUseCaseTest.givenValidArgsCallsProperFunctions);
    test("verify permissions",
        MarkAssignmentIncompleteUseCaseTest.verifyPermissions);
    test("verify results", MarkAssignmentIncompleteUseCaseTest.verifyResults);
  });
}
