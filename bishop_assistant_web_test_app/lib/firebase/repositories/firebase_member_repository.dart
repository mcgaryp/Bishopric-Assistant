import 'package:bishop_assistant_web_test_app/firebase/firestore_helper.dart';
import 'package:models/models/organization.dart';

///
/// firebase_member_repository.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 12/4/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

class FirebaseMemberRepository extends FirestoreHelper
    implements MemberRepository {
  FirebaseMemberRepository() : super(FirestoreCollectionPath.members);

  @override
  Future<Member?> find(MemberID id) async {
    Map<String, dynamic>? map = await getSingleDocument(id);
    if (map != null) {
      return Member.fromMap(map);
    }
    return null;
  }

  @override
  Stream<List<Stream<Member>>> findAllStreamed(OrganizationID organizationID) {
    Stream<List<Map<String, dynamic>>> streamedDocuments =
        getCollectionOfDocumentsStreamed(
            path: FirestoreCollectionPath.organization_members,
            field: OrganizationMemberRelationship.orgIdKey,
            isEqualTo: organizationID.id);

    Stream<List<Stream<Member>>> membersStream = streamedDocuments
        .asyncMap<List<Stream<Member>>>(
            (List<Map<String, dynamic>> snapshot) async {
      List<Stream<Member>> members = [];
      snapshot.forEach((element) {
        members.add(findStreamed(
            MemberID(element[OrganizationMemberRelationship.memberIdKey])));
      });
      return members;
    });
    return membersStream;
  }

  @override
  Future<Organization?> findOrganization(MemberID memberID) async {
    // find the document that connects the two
    List<Map<String, dynamic>> documents = await getCollectionOfDocuments(
        path: FirestoreCollectionPath.organization_members);
    OrganizationID? organizationID;
    for (Map<String, dynamic> document in documents) {
      // pull the organization id
      if (document[OrganizationMemberRelationship.memberIdKey] == memberID.id) {
        organizationID =
            OrganizationID(document[OrganizationMemberRelationship.orgIdKey]);
        break;
      }
    }

    // find the organization by organization id
    if (organizationID != null) {
      Map<String, dynamic>? map = await getSingleDocument(organizationID,
          path: FirestoreCollectionPath.organizations);

      if (map != null) {
        return Organization.fromMap(map);
      }
    }

    return null;
  }

  @override
  Future<Member?> insert(Member member) async {
    Map<String, dynamic> map = member.toMap;
    String? id = await addDocument(map);
    if (id == null) return null;
    map[Member.idKey] = id;
    Member newMember = Member.fromMap(map);
    if (await update(newMember)) return newMember;
  }

  @override
  Future<bool> remove(MemberID id) {
    return removeDocument(id);
  }

  @override
  Future<bool> update(Member member) {
    return updateDocument(member.toMap, member.id);
  }

  @override
  Future<Member?> findWithAccountID(AccountID accountID) async {
    List<Map<String, dynamic>> documents = await getCollectionOfDocuments(
        path: FirestoreCollectionPath.organization_members);
    for (Map<String, dynamic> document in documents) {
      if (document[OrganizationMemberRelationship.accountIdKey] ==
          accountID.id) {
        Member? member = await find(
            MemberID(document[OrganizationMemberRelationship.memberIdKey]));
        if (member != null) return member;
      }
    }
  }

  @override
  Future<List<Member>?> findAllWithAccountID(AccountID accountID) async {
    List<Member> members = [];
    List<Map<String, dynamic>> documents = await getCollectionOfDocuments(
        path: FirestoreCollectionPath.organization_members);
    for (Map<String, dynamic> document in documents) {
      if (document[OrganizationMemberRelationship.accountIdKey] ==
          accountID.id) {
        Member? member = await find(
            MemberID(document[OrganizationMemberRelationship.memberIdKey]));
        if (member != null) members.add(member);
      }
    }
    if (members.isEmpty) return null;
    return members;
  }

  @override
  Future<List<Member>> findAll(OrganizationID organizationID) async {
    List<Member> members = [];

    List<Map<String, dynamic>> documents = await getCollectionOfDocuments(
        path: FirestoreCollectionPath.organization_members,
        field: OrganizationMemberRelationship.orgIdKey,
        isEqualTo: organizationID.id);

    for (Map<String, dynamic> map in documents) {
      OrganizationMemberRelationship relationship =
          OrganizationMemberRelationship.fromMap(map);
      Member? member = await find(relationship.memberID);
      if (member != null) members.add(member);
    }

    return members;
  }

  @override
  Stream<Member> findStreamed(MemberID memberID) {
    return getSingleDocumentStreamed(memberID)
        .map<Member>((Map<String, dynamic>? map) => Member.fromMap(map!));
  }
}
