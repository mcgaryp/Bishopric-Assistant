import 'package:bishop_assistant_web_test_app/database/firestore_helper.dart';
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
    Map<String, dynamic>? map = await getSingleDocument(id);

    if (map == null) return null;
    Organization account = Organization.fromMap(map);
    return account;
  }

  @override
  Stream<List<Organization>> findAll() {
    Stream<List<Map<String, dynamic>>> stream =
        getCollectionOfDocumentsStreamed();

    Stream<List<Organization>> organizationStream = stream
        .asyncMap<List<Organization>>(
            (List<Map<String, dynamic>> documents) async {
      List<Organization> organizations = [];
      for (Map<String, dynamic> map in documents) {
        organizations.add(Organization.fromMap(map));
      }
      return organizations;
    });
    return organizationStream;
  }

  @override
  Future<Organization?> insert(Organization organization) async {
    Map<String, dynamic> map = organization.toMap;
    String? id = await addDocument(map);
    if (id == null) return null;
    map[Organization.idKey] = id;
    Organization newOrganization = Organization.fromMap(map);
    if (await update(newOrganization)) return newOrganization;
  }

  @override
  Future<bool> remove(OrganizationID id) {
    return removeDocument(id);
  }

  @override
  Future<bool> update(Organization organization) {
    return updateDocument(organization.toMap, organization.id);
  }

  @override
  Future<bool> insertRelationship(
      OrganizationMemberRelationship relationship) async {
    return null !=
        await addDocument(relationship.toMap,
            path: FirestoreCollectionPath.organization_members);
  }

  Future<Member?> findCreator(MemberID id) async {
    Map<String, dynamic>? map =
        await getSingleDocument(id, path: FirestoreCollectionPath.members);
    if (map != null) {
      return Member.fromMap(map);
    }
    return null;
  }

  @override
  Stream<List<JoinRequest>> findAllRequests(OrganizationID organizationID) {
    Stream<List<Map<String, dynamic>>> streamedDocuments =
        getCollectionOfDocumentsStreamed(
            path: FirestoreCollectionPath.organization_requests,
            field: JoinRequest.organizationIDKey,
            isEqualTo: organizationID.id);
    Stream<List<JoinRequest>> joinRequests = streamedDocuments
        .asyncMap<List<JoinRequest>>(
            (List<Map<String, dynamic>> snapshot) async {
      List<JoinRequest> requests = [];
      for (Map<String, dynamic> map in snapshot) {
        JoinRequest request = JoinRequest.fromMap(map);
        requests.add(request);
      }
      return requests;
    });
    return joinRequests;
  }

  @override
  Future<bool> requestToJoinOrganization(JoinRequest request) async {
    Map<String, dynamic> map = request.toMap;
    String? id = await addDocument(map,
        path: FirestoreCollectionPath.organization_requests);
    if (id == null) throw FailedToSaveError(forEntity: "Join Request");
    map[JoinRequest.idKey] = id;
    JoinRequest newRequest = JoinRequest.fromMap(map);
    return updateDocument(newRequest.toMap, newRequest.id!,
        path: FirestoreCollectionPath.organization_requests);
  }

  @override
  Future<bool> removeRequestToJoinOrganization(JoinRequest request) {
    return removeDocument(request.id!,
        path: FirestoreCollectionPath.organization_requests);
  }

  @override
  Future<Organization?> findByName(String name) async {
    List<Map<String, dynamic>> snapshots = await getCollectionOfDocuments(
        field: Organization.nameKey, isEqualTo: name);
    if (snapshots.isEmpty) return null;
    if (snapshots.length > 1)
      throw UnimplementedError(
          "There are more than one organization with the same name..."
          "This is not allowed");
    Map<String, dynamic> map = snapshots.first;
    return Organization.fromMap(map);
  }
}
