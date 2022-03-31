import 'package:flutter_test/flutter_test.dart';
import 'package:models/models/assignment.dart';

import '../../../mocks/assignment/mock_assignment_repository.dart';
import '../../../mocks/organization/mock_member_repository.dart';

///
/// unarchive_assignment_use_case_test.dart
///
///
/// Created by Joshua Bee on 2/7/22
/// Copyright 2022 Joshua Bee. All rights reserved.
///

class UnarchiveAssignmentUseCaseTest {
  // REPO FUNCTION CALLS
  // - Uses Member Repo
  //   - calls find
  // - Uses Assignment Repo
  //   - calls find
  //   - calls update
  static void givenValidArgsCallsProperFunctions() async {
    MockMemberRepository memberRepository = MockMemberRepository();
    MockAssignmentRepository assignmentRepository = MockAssignmentRepository();

    UnarchiveAssignmentUseCase useCase = DefaultUnarchiveAssignmentUseCase(
        memberRepository, assignmentRepository);
    await useCase.execute(
        memberID: memberRepository.member.id,
        assignmentID: assignmentRepository.assignment.id);

    ///Member Repository checks
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

    ///Assignment Repository Checks
    expect(assignmentRepository.findFlag, true);
    expect(assignmentRepository.findAllFlag, false);
    expect(assignmentRepository.insertFlag, false);
    expect(assignmentRepository.removeFlag, false);
    expect(assignmentRepository.updateFlag, true);
  }

  // CHECK RESULTS
  // - Returns true or false or errors
  static void verifyResults() async {
    MockMemberRepository memberRepository = MockMemberRepository();
    MockAssignmentRepository assignmentRepository = MockAssignmentRepository();
    ArchiveAssignmentUseCase useCase =
        DefaultArchiveAssignmentUseCase(memberRepository, assignmentRepository);
    bool result = await useCase.execute(
        memberID: memberRepository.member.id,
        assignmentID: assignmentRepository.assignment.id);
    expect(result, true);
  }

  // CHECK PERMISSIONS
  // - calls canArchive from Assignment
  static void verifyPermissions() async {
    /// permissions have been checked in [archive_assignment_use_case.dart]
  }

  /// Calls the find from member repo
  /// Checks permission level of the member
  /// Properly set the assignment isArchived boolean to true
  /// Calls unArchive() from assignment
  /// ensure that the assignment was properly archived and boolean is true
  /// Checks that update was called from assignment repo
}

runUnarchiveAssignmentUseCaseTest() {
  group("Unarchive Assignment Use Case Test", () {
    test("Verify repo function calls",
        UnarchiveAssignmentUseCaseTest.givenValidArgsCallsProperFunctions);
    test(
        "verify permissions", UnarchiveAssignmentUseCaseTest.verifyPermissions);
    test("verify results", UnarchiveAssignmentUseCaseTest.verifyResults);
  });
}
