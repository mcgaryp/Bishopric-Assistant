import 'package:flutter_test/flutter_test.dart';
import 'package:models/models/assignment.dart';
import 'package:models/shared/test.dart';

import '../../../mocks/assignment/mock_assignment_repository.dart';
import '../../../mocks/organization/mock_member_repository.dart';

///
/// update_assignment_use_case_test.dart
///
///
/// Created by Joshua Bee on 2/7/22
/// Copyright 2022 Joshua Bee. All rights reserved.
///

class UpdateAssignmentUseCaseTest implements Test {
  // REPO FUNCTION CALLS
  // - Uses Member Repo
  //   - calls find
  // - Uses Assignment Repo
  //   - calls find
  //   - calls update
  static void givenValidArgsCallsProperFunctions() async {
    MockAssignmentRepository assignmentRepository = MockAssignmentRepository();
    MockMemberRepository memberRepository = MockMemberRepository();
    UpdateAssignmentUseCase useCase =
        DefaultUpdateAssignmentUseCase(assignmentRepository, memberRepository);
    await useCase.execute(
        assignmentID: assignmentRepository.assignment.id,
        memberID: memberRepository.member.id);
    // Calls update from assignment repo
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
    // Only allows changes of title, dueDate, assignee, noteContent

    // Catch any errors and know what they should say
  }

  // CHECK PERMISSIONS
  //   // - calls canArchive from Assignment
  ///TODO verify permissions ?
  static void verifyPermissions() async {
    //have to be rank of whoever created it or above
  }

  // CHECK RESULTS
  // - Returns true or false or errors
  static void verifyResults() async {
    MockAssignmentRepository assignmentRepository = MockAssignmentRepository();
    MockMemberRepository memberRepository = MockMemberRepository();
    UpdateAssignmentUseCase useCase =
        DefaultUpdateAssignmentUseCase(assignmentRepository, memberRepository);
    bool results = await useCase.execute(
        assignmentID: assignmentRepository.assignment.id,
        memberID: memberRepository.member.id);
    expect(results, true);
  }
}

runUpdateAssignmentUseCaseTest() {
  group("Update Assignment Use Case Test", () {
    test("Verify repo function calls",
        UpdateAssignmentUseCaseTest.givenValidArgsCallsProperFunctions);
    test("verify permissions", UpdateAssignmentUseCaseTest.verifyPermissions);
    test("verify results", UpdateAssignmentUseCaseTest.verifyResults);
  });
}
