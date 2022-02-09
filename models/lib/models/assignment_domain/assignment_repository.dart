import 'package:models/models/assignment.dart';
import 'package:models/models/organization.dart';

///
/// assignment_repository.dart
/// bishopric-assistant
///
/// Created by Po on 9/25/21
/// Copyright 2021 Po. All rights reserved.
///

mixin AssignmentRepository {
  Stream<List<Stream<Assignment>>> findAllStreamedByOrganizationID(
      OrganizationID orgID);

  Future<Assignment?> insert(Assignment assignment);

  Future<Assignment?> find(AssignmentID assignmentID);

  Future<List<Assignment>> findAll(OrganizationID organizationID);

  Stream<Assignment> findStream(AssignmentID assignmentID);

  Future<bool> update(Assignment assignment);

  Future<bool> remove(AssignmentID assignmentID);
}
