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

    Organization account = Organization.fromMap(id, map);
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
        Member? member = await findCreator(MemberID(map["creator"]));

        if (member == null) throw MemberNotFoundError();
        map.addAll(member.toMap);
        Organization organization =
            Organization.fromMap(OrganizationID(map["id"]), map);
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
    Map<String, dynamic>? map =
        await getSingleDocument(id, path: FirestoreCollectionPath.members);
    if (map != null) return Member.fromMap(MemberID(map["id"]), map);
    return null;
  }

  @override
  Stream<List<JoinRequest>> findAllRequests(OrganizationID organizationID) {
    Stream<List<Map<String, dynamic>>> streamedDocuments =
        getCollectionOfDocumentsStreamed(
            path: FirestoreCollectionPath.organization_requests,
            field: "organizationID",
            isEqualTo: organizationID.id);
    Stream<List<JoinRequest>> joinRequests = streamedDocuments
        .asyncMap<List<JoinRequest>>(
            (List<Map<String, dynamic>> snapshot) async {
      List<JoinRequest> requests = [];
      for (Map<String, dynamic> map in snapshot) {
        JoinRequest request =
            JoinRequest.fromMap(map, JoinRequestID(map['id']));
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
    List<Map<String, dynamic>> snapshots = await getCollectionOfDocuments(
        field: "organizationName", isEqualTo: name);
    if (snapshots.isEmpty) return null;
    if (snapshots.length > 1)
      throw UnimplementedError(
          "There are more than one organization with the same name..."
          "This is not allowed");
    Map<String, dynamic> map = snapshots.first;
    OrganizationID organizationID = OrganizationID(map['id']);

    Member? member = await findCreator(MemberID(map["creator"]));
    if (member == null) throw MemberNotFoundError();

    map.addAll(member.toMap);
    return Organization.fromMap(organizationID, map);
  }
}
