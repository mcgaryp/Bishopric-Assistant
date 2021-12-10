import 'package:bishop_assistant_web_test_app/database/firestore_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:models/models/organization.dart';
import 'package:models/shared/exceptions.dart';

///
/// firebase_organization_repository.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 12/4/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

class FirebaseOrganizationRepository extends FirestoreHelper
    implements OrganizationRepository {
  FirebaseOrganizationRepository()
      : super(FirestoreCollectionPath.organizations);

  @override
  Future<Organization?> find(OrganizationID id) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await getSingleDocument(id);

    Map<String, dynamic>? map = snapshot.data();

    if (map == null) return null;

    Organization account = Organization.fromMap(id, map);
    return account;
  }

  @override
  Stream<List<Organization>> findAll(void o) {
    Stream<QuerySnapshot<Map<String, dynamic>>> stream =
        getCollectionOfDocumentsStreamed();

    Stream<List<Organization>> organizationStream = stream
        .asyncMap<List<Organization>>(
            (QuerySnapshot<Map<String, dynamic>> documents) async {
      List<Organization> organizations = [];

      for (QueryDocumentSnapshot<Map<String, dynamic>> document
          in documents.docs) {
        Map<String, dynamic> map = document.data();

        Member? member = await findCreator(MemberID(map["creator"]));

        if (member == null) throw MemberNotFoundError();
        map.addAll(member.toMap);
        Organization organization =
            Organization.fromMap(OrganizationID(document.id), map);
        organizations.add(organization);
      }
      return organizations;
    });

    return organizationStream;
  }

  @override
  Future<OrganizationID?> generateNextId() async {
    Map<String, dynamic>? snapshot = await getNextID();
    if (snapshot == null) return null;
    String id = snapshot[mPath.string].toString();
    if (id.isEmpty) return null;
    OrganizationID organizationID = OrganizationID(id);

    snapshot[mPath.string] += 1;
    bool success = await incrementId(snapshot);
    if (!success) return null;

    return organizationID;
  }

  @override
  Future<bool> insert(Organization organization) async {
    return await addDocument(organization.toMap, id: organization.id);
  }

  @override
  Future<bool> remove(OrganizationID i) {
    // TODO: implement remove
    throw UnimplementedError();
  }

  @override
  Future<bool> update(Organization m) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<bool> insertRelationship(OrganizationID organizationID,
      MemberID memberID, AccountID accountID) async {
    return await addDocument({
      "organizationID": organizationID.id,
      "memberID": memberID.id,
      "accountID": accountID.id
    }, path: FirestoreCollectionPath.organization_members);
  }

  Future<Member?> findCreator(MemberID id) async {
    DocumentSnapshot<Map<String, dynamic>> document =
        await getSingleDocument(id, path: FirestoreCollectionPath.members);
    Map<String, dynamic>? map = document.data();
    if (map != null) return Member.fromMap(MemberID(document.id), map);
    return null;
  }

  @override
  Stream<List<JoinRequest>> findAllRequests(OrganizationID organizationID) {
    Stream<QuerySnapshot<Map<String, dynamic>>> streamedDocuments =
        getCollectionOfDocumentsStreamed(
            path: FirestoreCollectionPath.organization_requests,
            field: "organizationID",
            isEqualTo: organizationID.id);
    Stream<List<JoinRequest>> joinRequests = streamedDocuments
        .asyncMap<List<JoinRequest>>(
            (QuerySnapshot<Map<String, dynamic>> snapshot) async {
      List<JoinRequest> requests = [];
      for (QueryDocumentSnapshot<Map<String, dynamic>> document
          in snapshot.docs) {
        Map<String, dynamic> map = document.data();
        JoinRequest request =
            JoinRequest.fromMap(map, JoinRequestID(document.id));
        requests.add(request);
      }
      return requests;
    });
    return joinRequests;
  }

  @override
  Future<bool> requestToJoinOrganization(JoinRequest request) {
    return addDocument(request.toMap,
        path: FirestoreCollectionPath.organization_requests);
  }

  @override
  Future<bool> removeRequestToJoinOrganization(JoinRequest request) {
    return removeDocument(request.id!,
        path: FirestoreCollectionPath.organization_requests);
  }
}
