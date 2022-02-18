import 'package:flutter_test/flutter_test.dart';
import 'package:models/models/assignment.dart';

import '../../../mocks/assignment/mock_assignment_repository.dart';
import '../../../mocks/organization/mock_member_repository.dart';

///
/// delete_assignment_use_case_tests.dart
///
///
/// Created by Porter McGary on 2/11/22
/// Copyright 2022 Porter McGary. All rights reserved.
///

class DeleteAssignmentUseCaseTests {
  // REPO FUNCTION CALL
  // - Uses assignment repo
  //   - Calls find
  //   - Calls remove
  // - Uses member repo
  //   - Calls find
  static void verifyFunctionRepoCalls() async {
    MockAssignmentRepository assignmentRepository = MockAssignmentRepository();
    MockMemberRepository memberRepository = MockMemberRepository();
    DeleteAssignmentUseCase useCase =
        DefaultDeleteAssignmentUseCase(assignmentRepository, memberRepository);
    await useCase.execute(
        assignmentID: assignmentRepository.assignment.id,
        memberID: memberRepository.member.id);

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
    expect(assignmentRepository.removeFlag, true);
    expect(assignmentRepository.updateFlag, false);
  }

  // ACCESSOR PERMISSION LEVEL
  // - Checks that accessor has permission to view the assignment based on the
  //   assignment canView method
  ///TODO: verify permissions ?
  static void verifyPermissions() async {
    //who is authorized to delete
  }

  // CHECK RESULTS
  // - Returns true is successful else false or throws an error
  static void verifyResults() async {
    MockAssignmentRepository assignmentRepository = MockAssignmentRepository();
    MockMemberRepository memberRepository = MockMemberRepository();
    DeleteAssignmentUseCase useCase =
        DefaultDeleteAssignmentUseCase(assignmentRepository, memberRepository);
    bool results = await useCase.execute(
        assignmentID: assignmentRepository.assignment.id,
        memberID: memberRepository.member.id);
    expect(results, true);
  }
}

runDeleteAssignmentUseCaseTests() {
  group("Delete Assignment Use Case Tests", () {
    test("Verify repo function calls",
        DeleteAssignmentUseCaseTests.verifyFunctionRepoCalls);
    test("verify permissions", DeleteAssignmentUseCaseTests.verifyPermissions);
    test("verify results", DeleteAssignmentUseCaseTests.verifyResults);
  });
}
