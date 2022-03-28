import 'package:flutter_test/flutter_test.dart';
import 'package:models/models/assignment.dart';
import 'package:models/models/organization.dart';
import 'package:models/shared/exceptions/exceptions.dart';
import 'package:models/shared/test.dart';

import '../../../mocks/assignment/mock_assignment.dart';
import '../../../mocks/assignment/mock_assignment_repository.dart';
import '../../../mocks/organization/mock_authorization.dart';
import '../../../mocks/organization/mock_member.dart';
import '../../../mocks/organization/mock_member_repository.dart';
import '../../../mocks/organization/mock_role.dart';

///
/// create_assignment_use_case_test.dart
///
///
/// Created by Joshua Bee on 2/7/22
/// Copyright 2022 Joshua Bee. All rights reserved.
///

class CreateAssignmentUseCaseTest implements Test {
  static void givenValidArgsCallsProperFunctions() async {
    Assignment assignment = MockAssignment().assignment;
    MockAssignmentRepository assignmentRepository =
        MockAssignmentRepository(isEmptyList: true);
    MockMemberRepository memberRepository = MockMemberRepository();
    try {
      CreateAssignmentUseCase useCase = DefaultCreateAssignmentUseCase(
          assignmentRepository, memberRepository);

      await useCase.execute(
          title: assignment.title,
          dueDate: assignment.dueDate,
          assignee: assignment.assignee,
          memberID: assignment.creator.id,
          note: assignment.note);
    } catch (e) {
      expect(true, "$e");
    }

    ///calls find from member repo
    expect(memberRepository.findFlag, true);

    ///calls findOrganization from member repo
    expect(memberRepository.findOrganizationFlag, true);
    expect(memberRepository.findAllFlag, false);
    expect(memberRepository.findAllStreamedFlag, false);
    expect(memberRepository.findAllWithAccountIDFlag, false);
    expect(memberRepository.findStreamedFlag, false);
    expect(memberRepository.insertFlag, false);
    expect(memberRepository.removeFlag, false);
    expect(memberRepository.updateFlag, false);

    ///calls insert from assignment repo
    expect(assignmentRepository.insertFlag, true);

    ///Check that remove is called from assignment repo
    expect(assignmentRepository.removeFlag, false);

    ///check it returns a true when the assignment has been placed in the repository correctly
    expect(assignmentRepository.updateFlag, false);
    expect(assignmentRepository.findFlag, false);

    ///This one is used when creating an assignment when checking for duplicates
    expect(assignmentRepository.findAllFlag, true);
    expect(assignmentRepository.findAllStreamedByOrganizationIDFlag, false);
    expect(assignmentRepository.findStreamFlag, false);
  }

  //this should be a viewer attempting to create an assignment
  static void givenInvalidPermissionErrorIsThrown(
      Authorization permission) async {
    /// TODO: Rewrite test
    // try {
    //   Member creator = MockMember(
    //           id: MockMemberID().id,
    //           role: MockRole(authorization: permission).role)
    //       .member;
    //   Assignment assignment =
    //       MockAssignment(creator: Creator.fromMember(creator)).assignment;
    //   AssignmentRepository assignmentRepository = MockAssignmentRepository();
    //   MockMemberRepository memberRepository =
    //       MockMemberRepository(member: creator);
    //
    //   CreateAssignmentUseCase useCase = DefaultCreateAssignmentUseCase(
    //       assignmentRepository, memberRepository);
    //
    //   await useCase.execute(
    //       title: assignment.title,
    //       dueDate: assignment.dueDate,
    //       assignee: assignment.assignee,
    //       memberID: assignment.creator.id,
    //       note: assignment.note);
    //   Test.fallthrough();
    // } catch (e) {
    //   expect(
    //       e.toString(),
    //       PermissionDeniedError(
    //               reason: "Insufficient privilege to create assignment")
    //           .toString());
    // }
  }

  static void givenValidPermissionAssignmentIsCreated(
      Authorization permission) async {
    try {
      Member creator = MockMember(
              id: MockMemberID().id,
              role: MockRole(authorization: permission).role)
          .member;
      Assignment assignment =
          MockAssignment(creator: Creator.fromMember(creator)).assignment;
      AssignmentRepository assignmentRepository =
          MockAssignmentRepository(isEmptyList: true);
      MockMemberRepository memberRepository =
          MockMemberRepository(member: creator);

      CreateAssignmentUseCase useCase = DefaultCreateAssignmentUseCase(
          assignmentRepository, memberRepository);

      await useCase.execute(
          title: assignment.title,
          dueDate: assignment.dueDate,
          assignee: assignment.assignee,
          memberID: assignment.creator.id,
          note: assignment.note);
    } catch (e) {
      expect(true, e.toString());
    }
  }

  static void givenAssignmentCheckForDuplicates() async {
    MockMemberRepository memberRepository = MockMemberRepository();
    // list is empty
    // - returns an assignment that was passed in
    Assignment assignment = MockAssignment().assignment;
    AssignmentRepository assignmentRepository =
        MockAssignmentRepository(isEmptyList: true, assignment: assignment);
    CreateAssignmentUseCase useCase =
        DefaultCreateAssignmentUseCase(assignmentRepository, memberRepository);

    Assignment result = await useCase.execute(
        title: assignment.title,
        dueDate: assignment.dueDate,
        assignee: assignment.assignee,
        memberID: assignment.creator.id,
        note: assignment.note);
    expect(result == assignment, true);
  }

  static void givenNoDuplicates() async {
    MockMemberRepository memberRepository = MockMemberRepository();
    Assignment assignment = MockAssignment().assignment;
    AssignmentRepository assignmentRepository =
        MockAssignmentRepository(isEmptyList: true);

    CreateAssignmentUseCase useCase =
        DefaultCreateAssignmentUseCase(assignmentRepository, memberRepository);
    Assignment result = await useCase.execute(
        title: assignment.title,
        dueDate: assignment.dueDate,
        assignee: assignment.assignee,
        memberID: assignment.creator.id,
        note: assignment.note);

    expect(result == assignment, true);
  }

  static void givenDuplicates() async {
    MockMemberRepository memberRepository = MockMemberRepository();
    Assignment assignment = MockAssignment().assignment;
    AssignmentRepository assignmentRepository = MockAssignmentRepository();
    // list is not empty
    // has a duplicate
    // - Throws an error, whats the error you expect
    try {
      CreateAssignmentUseCase useCase = DefaultCreateAssignmentUseCase(
          assignmentRepository, memberRepository);
      await useCase.execute(
          title: assignment.title,
          dueDate: assignment.dueDate,
          assignee: assignment.assignee,
          memberID: assignment.creator.id,
          note: assignment.note);
    } catch (error) {

      expect(
          error.toString(),
          FailedToSaveError(
                  reason:
                      "Cannot create assignment because assignment already exists")
              .toString());
    }
  }
}

runCreateAssignmentUseCaseTest() {
  group("Create Assignment Use Case Test", () {
    test(
        "Check that Viewer cannot create Assignment",
        () => CreateAssignmentUseCaseTest.givenInvalidPermissionErrorIsThrown(
            MockAuthorization.Unclassified));
    test(
        "Check that Creator can create Assignment",
        () =>
            CreateAssignmentUseCaseTest.givenValidPermissionAssignmentIsCreated(
                MockAuthorization.Protected));
    test(
        "Check that Maintainer can create Assignment",
        () =>
            CreateAssignmentUseCaseTest.givenValidPermissionAssignmentIsCreated(
                MockAuthorization.Confidential));
    test(
        "Check that Reporter can create Assignment",
        () =>
            CreateAssignmentUseCaseTest.givenValidPermissionAssignmentIsCreated(
                MockAuthorization.TopSecret));
    test("Checks proper repository calls",
        CreateAssignmentUseCaseTest.givenValidArgsCallsProperFunctions);
    test("Checks if the assignment already exists",
        CreateAssignmentUseCaseTest.givenAssignmentCheckForDuplicates);
    test("Checks if assignment can be made if it is not a duplicate",
        CreateAssignmentUseCaseTest.givenNoDuplicates);
    test("Checks if assignment fails to create because it is duplicate",
        CreateAssignmentUseCaseTest.givenDuplicates);
  });
}
