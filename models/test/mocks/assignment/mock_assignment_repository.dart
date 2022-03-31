import 'package:models/models/assignment.dart';
import 'package:models/models/organization_domain/organization_id.dart';

import 'mock_assignment.dart';

///
/// mock_assignment_repository.dart
/// bishopric-assistant
///
/// Created by Joshua Bee on 2/2/22
/// Copyright 2022 Joshua Bee. All rights reserved.
///

class MockAssignmentRepository implements AssignmentRepository {
  bool findFlag = false;
  bool findAllFlag = false;
  bool insertFlag = false;
  bool removeFlag = false;
  bool updateFlag = false;

  final Assignment assignment;
  final bool _isEmptyList;

  /// Mock Assignment Repository
  ///
  /// if you leave [assignment] null then the [assignment] becomes a `MockAssignment().assignment`
  /// [assignment] is the object returned for any functions that return an object [Assignment]
  /// [isEmptyList] forces any [List<Assignment>] to be returned as an empty [List]
  MockAssignmentRepository({Assignment? assignment, bool isEmptyList = false})
      : this.assignment = assignment ?? MockAssignment().assignment,
        this._isEmptyList = isEmptyList;

  @override
  Future<Assignment?> find(AssignmentID assignmentID) {
    findFlag = true;
    return Future.value(assignment);
  }

  @override
  Future<List<Assignment>> findAll(OrganizationID organizationID) {
    findAllFlag = true;

    return Future.value(_isEmptyList ? [] : List.filled(2, assignment));
  }

  @override
  Future<bool> insert(Assignment assignment) {
    insertFlag = true;
    return Future.value(true);
  }

  @override
  Future<bool> remove(AssignmentID assignmentID) {
    removeFlag = true;
    return Future.value(true);
  }

  @override
  Future<bool> update(Assignment assignment) {
    updateFlag = true;
    return Future.value(assignment == this.assignment);
  }
}
