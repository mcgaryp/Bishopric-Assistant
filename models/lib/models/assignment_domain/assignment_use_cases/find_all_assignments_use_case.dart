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

class DefaultFindAllAssignmentsUseCase implements FindAllAssignmentsUseCase {
  final AssignmentRepository _assignmentRepository;

  DefaultFindAllAssignmentsUseCase(this._assignmentRepository);

  @override
  Stream<List<Stream<Assignment>>> execute(OrganizationID id) {
    // Stream<List<Stream<Assignment>>> stream =
    //     _assignmentRepository.findAllStreamedByOrganizationID(id);
    //
    // // Filter out of the list the assignments that are archived
    // return stream
    //     .map<List<Stream<Assignment>>>((List<Stream<Assignment>> list) {
    //   List<Stream<Assignment>> theList = [];
    //   for (Stream<Assignment> stream in list) {
    //     theList.add(stream.where((assignment) {
    //       return assignment.isNotArchived;
    //     }));
    //   }
    //
    //   return theList;
    // });
    throw UnimplementedError("Find All Assignments Use Case");
  }
}
