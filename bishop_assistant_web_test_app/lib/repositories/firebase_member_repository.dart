import 'package:bishop_assistant_web_test_app/database/firestore_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:models/models/account_domain/account_id.dart';
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
    DocumentSnapshot<Map<String, dynamic>> document =
        await getSingleDocument(id);
    Map<String, dynamic>? map = document.data();
    if (map != null) {
      return Member.fromMap(id, map);
    }
    return null;
  }

  @override
  Stream<List<Member>> findAll(OrganizationID organizationID) {
    Stream<QuerySnapshot<Map<String, dynamic>>> streamedDocuments =
        getCollectionOfDocumentsStreamed(
            path: FirestoreCollectionPath.organization_members,
            field: "organizationID",
            isEqualTo: organizationID.id);
    Stream<List<Member>> membersStream = streamedDocuments
        .asyncMap<List<Member>>(
            (QuerySnapshot<Map<String, dynamic>> snapshot) async {
      List<Member> members = [];
      for (QueryDocumentSnapshot<Map<String, dynamic>> document
          in snapshot.docs) {
        Map<String, dynamic> map = document.data();
        Member? member = await find(MemberID(map["memberID"]));
        if (member != null) members.add(member);
      }
      return members;
    });
    return membersStream;
  }

  @override
  Future<Organization?> findOrganization(MemberID memberID) async {
    // find the document that connects the two
    QuerySnapshot<Map<String, dynamic>> documents =
        await getCollectionOfDocuments(
            path: FirestoreCollectionPath.organization_members);
    OrganizationID? organizationID;
    for (QueryDocumentSnapshot<Map<String, dynamic>> document
        in documents.docs) {
      // pull the organization id
      if (document.get("memberID") == memberID.id) {
        organizationID = OrganizationID(document.get("organizationID"));
        break;
      }
    }

    // find the organization by organization id
    if (organizationID != null) {
      DocumentSnapshot<Map<String, dynamic>> document = await getSingleDocument(
          organizationID,
          path: FirestoreCollectionPath.organizations);
      Map<String, dynamic>? map = document.data();

      if (map != null) {
        Member? member = await find(memberID);
        if (member != null) {
          map.addAll(member.toMap);
          return Organization.fromMap(organizationID, map);
        }
      }
    }

    return null;
  }

  @override
  Future<Member?> insert(Member member) async {
    String? id = await addDocument(member.toMap);
    if (id == null) return null;
    return Member.fromMap((MemberID(id)), member.toMap);
  }

  @override
  Future<bool> remove(MemberID id) {
    // TODO: implement remove
    throw UnimplementedError();
  }

  @override
  Future<bool> update(Member member) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<Member?> findWithAccountID(AccountID accountID) {
    // TODO: implement findWithAccountID
    throw UnimplementedError();
  }

  @override
  Future<List<Member>?> findAllWithAccountID(AccountID accountID) async {
    List<Member> members = [];
    QuerySnapshot<Map<String, dynamic>> documents =
        await getCollectionOfDocuments(
            path: FirestoreCollectionPath.organization_members);
    for (QueryDocumentSnapshot<Map<String, dynamic>> document
        in documents.docs) {
      if (document.data()['accountID'] == accountID.id) {
        Member? member = await find(MemberID(document.data()['memberID']));
        if (member != null) members.add(member);
      }
    }
    if (members.isEmpty) return null;
    return members;
  }
}
