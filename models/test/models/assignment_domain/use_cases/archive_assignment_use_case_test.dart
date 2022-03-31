import 'package:flutter_test/flutter_test.dart';
import 'package:models/models/assignment.dart';
import 'package:models/shared/test.dart';

import '../../../mocks/assignment/mock_assignment_repository.dart';
import '../../../mocks/organization/mock_member_repository.dart';

///
/// send_assignment_to_archive_use_case_test.dart
///
///
/// Created by Joshua Bee on 2/7/22
/// Copyright 2022 Joshua Bee. All rights reserved.
///

class ArchiveAssignmentUseCaseTest implements Test {
  // REPO FUNCTION CALLS
  // - Uses Member Repo
  //   - calls find
  // - Uses Assignment Repo
  //   - calls find
  //   - calls update
  static void givenValidArgsCallsProperFunctions() async {
    MockMemberRepository memberRepository = MockMemberRepository();
    MockAssignmentRepository assignmentRepository = MockAssignmentRepository();

    ArchiveAssignmentUseCase useCase =
        DefaultArchiveAssignmentUseCase(memberRepository, assignmentRepository);
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

  // CHECK PERMISSIONS
  // - Calls canArchive from assignment
  static void verifyPermissions() async {
    /// permissions have been checked in [archive_assignment_use_case.dart]
  }

  // CHECK RESULTS
  // - Returns errors or true or false
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
}

runArchiveAssignmentUseCaseTest() {
  group("Archive Assignment Use Case Test", () {
    test("Verify repo function calls",
        ArchiveAssignmentUseCaseTest.givenValidArgsCallsProperFunctions);
    test("verify permissions", ArchiveAssignmentUseCaseTest.verifyPermissions);
    test("verify results", ArchiveAssignmentUseCaseTest.verifyResults);
  });
}
