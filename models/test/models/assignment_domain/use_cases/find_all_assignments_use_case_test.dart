import 'package:flutter_test/flutter_test.dart';
import 'package:models/models/assignment_domain/assignment_use_cases/find_all_assignments_use_case.dart';
import 'package:models/shared/test.dart';

import '../../../mocks/assignment/mock_assignment_repository.dart';
import '../../../mocks/organization/mock_organization.dart';

///
/// find_all_assignments_use_case_test.dart
///
///
/// Created by Joshua Bee on 2/2/22
/// Copyright 2022 Joshua Bee. All rights reserved.
///

class FindAllAssignmentsUseCaseTest implements Test {
  static void givenValidArgsCallsProperFunctions() {
    MockAssignmentRepository repository = MockAssignmentRepository();
    FindAllAssignmentsUseCase useCase =
        DefaultFindAllAssignmentsUseCase(repository);
    useCase.execute(MockOrganizationID().id);
    expect(repository.findFlag, false);
    expect(repository.findAllFlag, false);
    expect(repository.findAllStreamedByOrganizationIDFlag, true);
    expect(repository.findStreamFlag, false);
    expect(repository.insertFlag, false);
    expect(repository.removeFlag, false);
    expect(repository.updateFlag, false);
  }
}

runFindAllAssignmentsUseCaseTest() {
  test("Find All Assignments Use Case Tests",
      FindAllAssignmentsUseCaseTest.givenValidArgsCallsProperFunctions);
}
