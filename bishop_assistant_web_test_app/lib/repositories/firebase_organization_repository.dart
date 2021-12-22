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
  Stream<List<Organization>> findAll() {
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
  Future<Organization?> insert(Organization organization) async {
    String? id = await addDocument(organization.toMap);
    if (id == null) return null;
    Map<String, dynamic> map = organization.toMap;
    map.addAll(organization.creator.toMap);
    return Organization.fromMap(OrganizationID(id), map);
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
    return null !=
        await addDocument({
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
  Future<bool> requestToJoinOrganization(JoinRequest request) async {
    return null !=
        await addDocument(request.toMap,
            path: FirestoreCollectionPath.organization_requests);
  }

  @override
  Future<bool> removeRequestToJoinOrganization(JoinRequest request) {
    return removeDocument(request.id!,
        path: FirestoreCollectionPath.organization_requests);
  }

  @override
  Future<Organization?> findByName(String name) async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await getCollectionOfDocuments(
            field: "organizationName", isEqualTo: name);
    if (snapshot.docs.isEmpty) return null;
    if (snapshot.docs.length > 1)
      throw UnimplementedError(
          "There are more than one organization with the same name..."
          "This is not allowed");
    DocumentSnapshot<Map<String, dynamic>?> document = snapshot.docs.first;
    Map<String, dynamic>? map = document.data();
    if (map == null) return null;
    OrganizationID organizationID = OrganizationID(document.id);

    Member? member = await findCreator(MemberID(map["creator"]));
    if (member == null) throw MemberNotFoundError();

    map.addAll(member.toMap);
    return Organization.fromMap(organizationID, map);
  }
}
