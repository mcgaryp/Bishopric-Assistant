import 'package:flutter_test/flutter_test.dart';
import 'package:models/models/assignment.dart';
import 'package:models/models/organization_domain/organization_id.dart';

import '../../../mocks/assignment/mock_assignment_repository.dart';
import '../../../mocks/organization/mock_organization.dart';

///
/// find_all_archived_assignments_use_case_test.dart
///
///
/// Created by Porter McGary on 2/11/22
/// Copyright 2022 Porter McGary. All rights reserved.
///

class FindAllArchivedAssignmentsUseCaseTests {
  // REPO FUNCTION CALLS
  // - Uses Assignment Repo
  //   - calls findAllStreamed
  static void verifyFunctionRepoCalls() async {
    MockAssignmentRepository assignmentRepository = MockAssignmentRepository();
    OrganizationID organizationID = MockOrganizationID().id;
    FindAllArchivedAssignmentsUseCase useCase =
        DefaultFindAllArchivedAssignmentsUseCase(assignmentRepository);
    await useCase.execute(organizationID); //to get flags set for checking below

    ///Assignment Repository checks
    expect(assignmentRepository.findFlag, false);
    expect(assignmentRepository.findAllFlag, false);
    expect(assignmentRepository.findAllStreamedByOrganizationIDFlag, true);
    expect(assignmentRepository.findStreamFlag, false);
    expect(assignmentRepository.insertFlag, false);
    expect(assignmentRepository.removeFlag, false);
    expect(assignmentRepository.updateFlag, false);
  }

  // CHECK RESULTS
  // - throws proper errors
  // - returns a Stream<List<Stream<Assignment>>>
  static void verifyResults() async {
    MockAssignmentRepository assignmentRepository = MockAssignmentRepository();
    OrganizationID organizationID = MockOrganizationID().id;
    FindAllArchivedAssignmentsUseCase useCase =
        DefaultFindAllArchivedAssignmentsUseCase(assignmentRepository);
    Stream<List<Stream<Assignment>>> result =
        await useCase.execute(organizationID);

    ///Somehow make sure it returns properly

    // try {//Implement later
    //   //force an error here
    //   await useCase.execute();
    // } catch (e) {
    //   //assignmentnotfounderror
    // }
  }

  // TODO: VERIFY PERMISSIONS ?
  static void verifyPermissions() async {
    // Make sure permission level of viewer matches permission level of
    // each assignment
  }
}

runFindAllArchivedAssignmentsUseCaseTests() {
  group("Find All Archived Assignments Use Case Tests", () {
    test("Verify repo function calls",
        FindAllArchivedAssignmentsUseCaseTests.verifyFunctionRepoCalls);
    test("verify permissions",
        FindAllArchivedAssignmentsUseCaseTests.verifyPermissions);
    test(
        "verify results", FindAllArchivedAssignmentsUseCaseTests.verifyResults);
  });
}
