import 'package:the_assistant/firebase/firestore_helper.dart';
import 'package:the_assistant/firebase/repositories/repositories.dart';
import 'package:models/models/account.dart';
import 'package:models/models/organization.dart';
import 'package:models/shared/exceptions/exceptions.dart';

///
/// $FILE_NAME.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 3/16/22
/// Copyright 2022 Porter McGary. All rights reserved.
///

class FirestoreMemberRepository extends FirestoreHelper
    implements MemberRepository {
  FirestoreMemberRepository() : super(FirestoreCollectionPath.members);

  FirestoreCollectionPath _namePath = FirestoreCollectionPath.name;
  FirestoreCollectionPath _contactPath = FirestoreCollectionPath.contact;
  FirestoreCollectionPath _organizationPath =
      FirestoreCollectionPath.organizations;

  FirestoreRoleRepository _roleRepository = FirestoreRoleRepository();

  @override
  Future<Member> find(MemberID id) async {
    // convert to DB Member
    DBMember dbMember = DBMember.fromMap(await getSingleDocument(id));

    // Find contact
    DBContact dbContact = DBContact.fromMap(await getSingleDocument(
      dbMember.toContactID,
      path: _contactPath,
    ));

    // Find name
    DBName dbName = DBName.fromMap(await getSingleDocument(
      dbMember.toNameID,
      path: _namePath,
    ));

    // Find Role
    Role role = await _roleRepository.find(
        dbMember.toRoleID, dbMember.toOrganizationID);

    // Convert to Member
    Member member = Member(
      role: role,
      contact: dbContact.toContact,
      name: dbName.toName,
      id: dbMember.toMemberID,
    );

    return member;
  }

  @override
  Future<List<Member>> findAll(OrganizationID id) async {
    // get maps
    List<Map<String, dynamic>> maps = await getCollectionOfDocuments(
        field: DBMember.organizationIDKey, isEqualTo: id.id);

    // Convert to DB Members
    List<DBMember> dbMembers = maps
        .map<DBMember>((Map<String, dynamic> map) => DBMember.fromMap(map))
        .toList();

    // Convert to members
    List<Member> members = [];
    for (DBMember dbMember in dbMembers) {
      members.add(await find(dbMember.toMemberID));
    }

    return members;
  }

  @override
  Future<List<Member>> findAllWithAccountID(AccountID accountID) async {
    List<DBMember> dbMembers = (await getCollectionOfDocuments())
        .map<DBMember>((Map<String, dynamic> map) => DBMember.fromMap(map))
        .toList();

    List<Member> members = [];

    for (DBMember dbMember in dbMembers) {
      if (dbMember.toAccountID == accountID) {
        members.add(await find(dbMember.toMemberID));
      }
    }

    return members;
  }

  @override
  Future<Organization?> findOrganization(MemberID id) async {
    // convert to DB Member
    DBMember dbMember = DBMember.fromMap(await getSingleDocument(id));

    // find organization
    DBOrganization dbOrganization = DBOrganization.fromMap(
        await getSingleDocument(dbMember.toOrganizationID,
            path: _organizationPath));

    Member creator = await find(dbOrganization.toCreatorID);
    Organization organization = Organization(
        id: dbOrganization.toOrganizationID,
        name: dbOrganization.toName,
        creator: creator);

    return organization;
  }

  @override
  Future<Member?> findWithAccountID(AccountID id) async {
    // get members
    List<DBMember> members = (await getCollectionOfDocuments())
        .map<DBMember>((Map<String, dynamic> map) => DBMember.fromMap(map))
        .toList();

    // find the same account
    for (DBMember member in members) {
      if (member.toAccountID == id) {
        return find(member.toMemberID);
      }
    }

    return null;
  }

  @override
  Future<bool> insert(
      Member member, OrganizationID organizationID, AccountID accountID) async {
    // find account
    DBAccount dbAccount = DBAccount.fromMap(await getSingleDocument(accountID,
        path: FirestoreCollectionPath.accounts));

    // convert to DB member
    DBMember dbMember = DBMember(
      nameID: dbAccount.nameID,
      contactID: dbAccount.contactID,
      accountID: dbAccount.accountID,
      organizationID: organizationID.id,
      roleID: member.role.id.id,
    );

    // insert
    String? memberID = await addDocument(dbMember.toMap);

    // update
    dbMember.memberID = memberID;
    return await updateDocument(
        dbMember.toMap, MemberID(dbMember.memberID ?? ""));
  }

  @override
  Future<bool> remove(MemberID id) {
    return removeDocument(id);
  }

  @override
  Future<bool> update(Member member) async {
    // Find Document convert to DB Member
    DBMember dbMember = DBMember.fromMap(await getSingleDocument(member.id));

    // NOTE: the only thing that ever changes is the role, all other properties
    //  are IDs
    dbMember.roleID = member.role.id.id;

    // update
    return updateDocument(dbMember.toMap, dbMember.toMemberID);
  }

  Stream<Member> findStreamed(MemberID id) {
    return getSingleDocumentStreamed(id)
        .asyncMap<Member>((Map<String, dynamic>? map) async {
      // convert to DB Member
      map ?? (throw MemberNotFoundError());
      DBMember dbMember = DBMember.fromMap(map);

      // Pull out components
      // TODO: Adjust to pull a stream...
      // Contact
      DBContact dbContact = DBContact.fromMap(
          await getSingleDocument(dbMember.toContactID, path: _contactPath));

      // Name
      DBName dbName = DBName.fromMap(
          await getSingleDocument(dbMember.toNameID, path: _namePath));

      // Role
      Role role = await _roleRepository.find(
          dbMember.toRoleID, dbMember.toOrganizationID);

      // Create Member from components
      return Member(
        contact: dbContact.toContact,
        role: role,
        name: dbName.toName,
        id: dbMember.toMemberID,
      );
    });
  }

  Stream<List<Stream<Member>>> findAllStreamed(OrganizationID id) {
    return getCollectionOfDocumentsStreamed(
            field: DBMember.organizationIDKey, isEqualTo: id.id)
        .asyncMap<List<Stream<Member>>>((List<Map<String, dynamic>> maps) {
      return maps.map<Stream<Member>>((Map<String, dynamic> map) {
        DBMember dbMember = DBMember.fromMap(map);
        return findStreamed(dbMember.toMemberID);
      }).toList();
    });
  }
}
