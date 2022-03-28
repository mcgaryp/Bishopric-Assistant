import 'package:bishop_assistant_web_test_app/firebase/firestore_helper.dart';
import 'package:models/models/assignment.dart';
import 'package:models/models/organization_domain/organization_id.dart';
import 'package:models/shared/exceptions/account_not_found_error.dart';

///
/// $NAME.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 3/25/22
/// Copyright 2022 Porter McGary. All rights reserved.
///

class FirestoreAssignmentRepository extends FirestoreHelper
    implements AssignmentRepository {
  FirestoreAssignmentRepository() : super(FirestoreCollectionPath.assignments);

  @override
  Future<Assignment> find(AssignmentID assignmentID) {
    // TODO: implement find
    throw UnimplementedError("Find Assignment Repo");
  }

  @override
  Future<List<Assignment>> findAll(OrganizationID organizationID) {
    // TODO: implement findAll
    throw UnimplementedError("Find All Assignment Repo");
  }

  @override
  Future<Assignment?> insert(Assignment assignment) {
    // TODO: implement insert
    throw UnimplementedError("Insert Assignment Repo");
  }

  @override
  Future<bool> remove(AssignmentID assignmentID) {
    // TODO: implement remove
    throw UnimplementedError("Remove Assignment Repo");
  }

  @override
  Future<bool> update(Assignment assignment) {
    // TODO: implement update
    throw UnimplementedError("Update Assignment Repo");
  }

  Stream<Assignment> findStreamed(AssignmentID assignmentID) {
    return getSingleDocumentStreamed(assignmentID)
        .asyncMap<Assignment>((Map<String, dynamic>? map) {
      if (map == null) throw AccountNotFoundError();
      DBAssignment dbAssignment = DBAssignment.fromMap(map);
      return find(dbAssignment.toAssignmentID);
    });
  }

  Stream<List<Stream<Assignment>>> findAllStreamed(
      OrganizationID organizationID) {
    return getCollectionOfDocumentsStreamed()
        .map<List<Stream<Assignment>>>((List<Map<String, dynamic>> maps) {
      return maps.map<Stream<Assignment>>((Map<String, dynamic> map) {
        DBAssignment dbAssignment = DBAssignment.fromMap(map);
        return findStreamed(dbAssignment.toAssignmentID);
      }).toList();
    });
  }
}
