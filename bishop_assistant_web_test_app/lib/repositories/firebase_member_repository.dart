import 'package:bishop_assistant_web_test_app/database/firestore_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:models/models/organization.dart';
import 'package:models/shared/exceptions.dart';

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

  Stream<Member> findMemberStreamed(MemberID id) {
    Stream<DocumentSnapshot<Map<String, dynamic>>> documentStream =
        getSingleDocumentStreamed(id);
    Stream<Member> memberStream = documentStream
        .asyncMap<Member>((DocumentSnapshot<Map<String, dynamic>> event) async {
      Map<String, dynamic>? map = event.data();
      if (map == null) throw MemberNotFoundError();
      Member member = Member.fromMap(id, map);
      return member;
    });
    return memberStream;
  }

  @override
  Stream<List<Stream<Member>>> findAll(OrganizationID organizationID) {
    Stream<QuerySnapshot<Map<String, dynamic>>> streamedDocuments =
        getCollectionOfDocumentsStreamed(
            path: FirestoreCollectionPath.organization_members,
            field: "organizationID",
            isEqualTo: organizationID.id);

    Stream<List<Stream<Member>>> membersStream = streamedDocuments
        .asyncMap<List<Stream<Member>>>(
            (QuerySnapshot<Map<String, dynamic>> snapshot) async {
      List<Stream<Member>> members = [];
      snapshot.docs.forEach((element) {
        members.add(findMemberStreamed(MemberID(element["memberID"])));
      });
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
    return updateDocument(member.toMap, member.id);
  }

  @override
  Future<Member?> findWithAccountID(AccountID accountID) async {
    QuerySnapshot<Map<String, dynamic>> documents =
        await getCollectionOfDocuments(
            path: FirestoreCollectionPath.organization_members);
    for (QueryDocumentSnapshot<Map<String, dynamic>> document
        in documents.docs) {
      if (document.data()['accountID'] == accountID.id) {
        Member? member = await find(MemberID(document.data()['memberID']));
        if (member != null) return member;
      }
    }
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
