import 'package:bishop_assistant_web_test_app/database/firestore_helper.dart';
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
    Map<String, dynamic>? map = await getSingleDocument(id);
    if (map != null) {
      return Member.fromMap(id, map);
    }
    return null;
  }

  Stream<Member> findMemberStreamed(MemberID id) {
    Stream<Map<String, dynamic>?> documentStream =
        getSingleDocumentStreamed(id);
    Stream<Member> memberStream =
        documentStream.asyncMap<Member>((Map<String, dynamic>? map) async {
      if (map == null) throw MemberNotFoundError();
      Member member = Member.fromMap(id, map);
      return member;
    });
    return memberStream;
  }

  @override
  Stream<List<Stream<Member>>> findAll(OrganizationID organizationID) {
    Stream<List<Map<String, dynamic>>> streamedDocuments =
        getCollectionOfDocumentsStreamed(
            path: FirestoreCollectionPath.organization_members,
            field: "organizationID",
            isEqualTo: organizationID.id);

    Stream<List<Stream<Member>>> membersStream = streamedDocuments
        .asyncMap<List<Stream<Member>>>(
            (List<Map<String, dynamic>> snapshot) async {
      List<Stream<Member>> members = [];
      snapshot.forEach((element) {
        members.add(findMemberStreamed(MemberID(element["memberID"])));
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
      if (document["memberID"] == memberID.id) {
        organizationID = OrganizationID(document["organizationID"]);
        break;
      }
    }

    // find the organization by organization id
    if (organizationID != null) {
      Map<String, dynamic>? map = await getSingleDocument(organizationID,
          path: FirestoreCollectionPath.organizations);

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
    List<Map<String, dynamic>> documents = await getCollectionOfDocuments(
        path: FirestoreCollectionPath.organization_members);
    for (Map<String, dynamic> document in documents) {
      if (document['accountID'] == accountID.id) {
        Member? member = await find(MemberID(document['memberID']));
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
      if (document['accountID'] == accountID.id) {
        Member? member = await find(MemberID(document['memberID']));
        if (member != null) members.add(member);
      }
    }
    if (members.isEmpty) return null;
    return members;
  }
}
