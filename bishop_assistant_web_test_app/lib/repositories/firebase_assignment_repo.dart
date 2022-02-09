import 'package:bishop_assistant_web_test_app/database/firestore_helper.dart';
import 'package:models/models/assignment.dart';
import 'package:models/models/organization_domain/organization_id.dart';
import 'package:models/shared/exceptions.dart';

///
/// firebase_assignment_repo.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 1/19/22
/// Copyright 2022 Porter McGary. All rights reserved.
///

class FirebaseAssignmentRepo extends FirestoreHelper
    implements AssignmentRepository {
  FirebaseAssignmentRepo() : super(FirestoreCollectionPath.assignments);

  @override
  Future<Assignment?> find(AssignmentID assignmentID) async {
    Map<String, dynamic>? map = await getSingleDocument(assignmentID);
    if (map == null) throw AssignmentNotFoundError();
    return Assignment.fromMap(map);
  }

  @override
  Stream<Assignment> findStream(AssignmentID assignmentID) {
    Stream<Map<String, dynamic>?> map = getSingleDocumentStreamed(assignmentID);
    return map.asyncMap<Assignment>((event) {
      if (event == null) throw AssignmentNotFoundError();
      return Assignment.fromMap(event);
    });
  }

  @override
  Stream<List<Stream<Assignment>>> findAllStreamedByOrganizationID(
      OrganizationID orgID) {
    Stream<List<Map<String, dynamic>>> streamedDocuments =
        getCollectionOfDocumentsStreamed(
            path: FirestoreCollectionPath.assignments,
            field: Assignment.orgIDKey,
            isEqualTo: orgID.id,
            sortBy: Assignment.dueDateKey);
    return streamedDocuments.map<List<Stream<Assignment>>>(
        (List<Map<String, dynamic>> list) => list
            .map<Stream<Assignment>>((Map<String, dynamic> map) =>
                findStream(AssignmentID(map[Assignment.idKey])))
            .toList());
  }

  @override
  Future<Assignment?> insert(Assignment assignment) async {
    Map<String, dynamic> map = assignment.toMap;
    String? id = await addDocument(map);
    if (id == null) throw FailedToSaveError(forEntity: "Assignment");
    map[Assignment.idKey] = id;
    Assignment newAssignment = Assignment.fromMap(map);
    if (await update(newAssignment))
      return newAssignment;
    else
      remove(AssignmentID(id));
    throw FailedToSaveError(forEntity: "Assignment");
  }

  @override
  Future<bool> update(Assignment assignment) {
    return updateDocument(assignment.toMap, assignment.id);
  }

  @override
  Future<bool> remove(AssignmentID assignmentID) {
    return removeDocument(assignmentID);
  }

  @override
  Future<List<Assignment>> findAll(OrganizationID organizationID) async {
    List<Map<String, dynamic>> documents = await getCollectionOfDocuments(
        field: Assignment.orgIDKey,
        isEqualTo: organizationID.id,
        sortBy: Assignment.dueDateKey);

    return documents
        .map<Assignment>((Map<String, dynamic> map) => Assignment.fromMap(map))
        .toList();
  }
}
