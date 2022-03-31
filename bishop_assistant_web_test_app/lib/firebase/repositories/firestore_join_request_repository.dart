import 'package:bishop_assistant_web_test_app/firebase/firestore_helper.dart';
import 'package:models/models/organization.dart';

///
/// $FILE_NAME.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 3/17/22
/// Copyright 2022 Porter McGary. All rights reserved.
///

class FirestoreJoinRequestRepository extends FirestoreHelper
    implements JoinRequestRepository {
  FirestoreJoinRequestRepository() : super(FirestoreCollectionPath.requests);

  @override
  Future<JoinRequest> find(JoinRequestID id) async {
    // Convert to DB JoinRequest
    DBJoinRequest dbJoinRequest =
        DBJoinRequest.fromMap(await getSingleDocument(id));

    // convert to join request
    JoinRequest joinRequest = dbJoinRequest.toJoinRequest;
    return joinRequest;
  }

  @override
  Future<bool> insert(JoinRequest joinRequest) async {
    // convert to DB Join Request
    DBJoinRequest dbJoinRequest = DBJoinRequest.fromJoinRequest(joinRequest);

    // insert
    String? id = await addDocument(dbJoinRequest.toMap);

    // update
    dbJoinRequest.requestID = id;
    return updateDocument(dbJoinRequest.toMap, dbJoinRequest.toJoinRequestID);
  }

  @override
  Future<bool> remove(JoinRequestID id) {
    return removeDocument(id);
  }

  Stream<List<JoinRequest>> findAllStreamed(OrganizationID id) {
    return getCollectionOfDocumentsStreamed(
            field: DBJoinRequest.organizationIDKey, isEqualTo: id.id)
        .asyncMap<List<JoinRequest>>((List<Map<String, dynamic>> maps) {
      return maps.map<JoinRequest>((Map<String, dynamic> map) {
        // convert to DB Join Request
        DBJoinRequest dbJoinRequest = DBJoinRequest.fromMap(map);
        // convert to to Join request
        return dbJoinRequest.toJoinRequest;
      }).toList();
    });
  }

  @override
  Future<List<JoinRequest>> findAll(OrganizationID id) async {
    // convert to DB Join Request
    List<DBJoinRequest> dbRequests = (await getCollectionOfDocuments(
            field: DBJoinRequest.organizationIDKey, isEqualTo: id.id))
        .map<DBJoinRequest>(
            (Map<String, dynamic> map) => DBJoinRequest.fromMap(map))
        .toList();

    // convert to Requests
    List<JoinRequest> requests = [];
    for (DBJoinRequest dbJoinRequest in dbRequests) {
      requests.add(dbJoinRequest.toJoinRequest);
    }

    return requests;
  }
}
