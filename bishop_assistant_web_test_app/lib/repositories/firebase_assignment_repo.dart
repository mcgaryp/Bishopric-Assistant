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
            path: FirestoreCollectionPath.organization_assignments,
            field: OrganizationAssignmentRelationship.organizationKey,
            isEqualTo: orgID.id);
    Stream<List<Stream<Assignment>>> assignmentsStream = streamedDocuments
        .asyncMap<List<Stream<Assignment>>>(
            (List<Map<String, dynamic>> snapshot) async {
      List<Stream<Assignment>> assignments = [];
      snapshot.forEach((element) {
        assignments.add(findStream(AssignmentID(element[Assignment.idKey])));
      });
      return assignments;
    });
    return assignmentsStream;
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
  Future<bool> insertRelationship(
      OrganizationAssignmentRelationship organizationAssignment) async {
    String? id = await addDocument(organizationAssignment.toMap,
        path: FirestoreCollectionPath.organization_assignments);
    if (id == null)
      throw FailedToSaveError(
          forEntity: "Organization Assignment Relationship");
    return true;
  }

  @override
  Future<bool> remove(AssignmentID assignmentID) {
    return removeDocument(assignmentID);
  }

  @override
  Future<List<Assignment>> findAll(OrganizationID organizationID) {
    // TODO: implement findAll
    throw UnimplementedError();
  }
}
