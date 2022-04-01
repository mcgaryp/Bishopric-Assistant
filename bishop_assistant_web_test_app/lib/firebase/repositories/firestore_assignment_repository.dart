import 'package:the_assistant/firebase/firestore_helper.dart';
import 'package:the_assistant/firebase/repositories/firestore_role_repository.dart';
import 'package:models/models/assignment.dart';
import 'package:models/models/organization.dart';
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
  Future<Assignment> find(AssignmentID assignmentID) async {
    // convert to DB Assignment
    Map<String, dynamic> map = await getSingleDocument(assignmentID);
    DBAssignment dbAssignment = DBAssignment.fromMap(map);

    FirestoreRoleRepository roleRepository = FirestoreRoleRepository();
    // Find Creator
    Role creator = await roleRepository.find(
        dbAssignment.toCreatorID, dbAssignment.toOrganizationID);

    // Find Assignee
    Role assignee = await roleRepository.find(
        dbAssignment.toAssigneeID, dbAssignment.toOrganizationID);

    // Find Viewers
    List<Role> viewers = [];
    for (String? id in dbAssignment.viewers) {
      if (id != null)
        viewers.add(await roleRepository.find(
            RoleID(id), dbAssignment.toOrganizationID));
    }

    // convert to Assignment
    Assignment assignment = dbAssignment.toAssignment(
      creator: creator,
      assignee: assignee,
      viewers: viewers,
    );

    return assignment;
  }

  @override
  Future<List<Assignment>> findAll(OrganizationID organizationID) async {
    // convert to DBAssignment
    List<DBAssignment> dbAssignments = (await getCollectionOfDocuments())
        .map<DBAssignment>(
            (Map<String, dynamic> map) => DBAssignment.fromMap(map))
        .toList();

    // convert to Assignments
    List<Assignment> assignments = [];
    for (DBAssignment dbAssignment in dbAssignments) {
      assignments.add(await find(dbAssignment.toAssignmentID));
    }

    return assignments;
  }

  @override
  Future<bool> insert(Assignment assignment) async {
    // Convert to Assignment DB
    DBAssignment dbAssignment = DBAssignment.fromAssignment(assignment);
    String? id = await addDocument(dbAssignment.toMap);
    if (id == null) return false;
    dbAssignment.assignmentID = id;
    return updateDocument(dbAssignment.toMap, dbAssignment.toAssignmentID);
  }

  @override
  Future<bool> remove(AssignmentID assignmentID) {
    return removeDocument(assignmentID);
  }

  @override
  Future<bool> update(Assignment assignment) {
    // Convert to DB Assignment
    DBAssignment dbAssignment =
        DBAssignment.fromAssignment(assignment, hasID: true);

    // update
    return updateDocument(dbAssignment.toMap, dbAssignment.toAssignmentID);
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
