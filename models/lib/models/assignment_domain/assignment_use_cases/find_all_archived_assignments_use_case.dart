import 'package:models/models/assignment.dart';
import 'package:models/models/organization.dart';

///
/// find_all_archived_assignments_use_case.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 2/7/22
/// Copyright 2022 Porter McGary. All rights reserved.
///

mixin FindAllArchivedAssignmentsUseCase {
  @required
  Stream<List<Stream<Assignment>>> execute(OrganizationID id);
}

class DefaultFindAllArchivedAssignmentsUseCase
    implements FindAllArchivedAssignmentsUseCase {
  final AssignmentRepository _assignmentRepository;

  DefaultFindAllArchivedAssignmentsUseCase(this._assignmentRepository);

  @override
  Stream<List<Stream<Assignment>>> execute(OrganizationID id) {
    Stream<List<Stream<Assignment>>> stream =
        _assignmentRepository.findAllStreamedByOrganizationID(id);

    // Filter out of the list the assignments that are unarchived
    return stream
        .map<List<Stream<Assignment>>>((List<Stream<Assignment>> list) {
      List<Stream<Assignment>> theList = [];
      for (Stream<Assignment> stream in list) {
        theList.add(stream.where((assignment) => assignment.isArchived));
      }

      return theList;
    });
  }
}
