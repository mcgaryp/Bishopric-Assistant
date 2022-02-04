import 'package:models/models/assignment.dart';
import 'package:models/models/organization.dart';

///
/// find_all_assignments_use_case.dart
/// bishopric-assistant
///
/// Created by Joshua Bee on 1/21/22
/// Copyright 2022 Joshua Bee. All rights reserved.
///

mixin FindAllAssignmentsUseCase {
  @required
  Stream<List<Stream<Assignment>>> execute(OrganizationID id);
}

class DefaultAllAssignmentsUseCase implements FindAllAssignmentsUseCase {
  final AssignmentRepository _assignmentRepository;

  DefaultAllAssignmentsUseCase(this._assignmentRepository);

  @override
  Stream<List<Stream<Assignment>>> execute(OrganizationID id) {
    return _assignmentRepository.findAllStreamedByOrganizationID(id);
  }
}
