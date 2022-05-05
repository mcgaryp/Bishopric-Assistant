import 'package:models/models/organization.dart';
import 'package:models/shared/exceptions/exceptions.dart';
import 'package:the_assistant/firebase/firestore_helper.dart';
import 'package:the_assistant/firebase/repositories/repositories.dart';

///
/// $FILE_NAME.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 3/16/22
/// Copyright 2022 Porter McGary. All rights reserved.
///

class FirestoreOrganizationRepository extends FirestoreHelper
    implements OrganizationRepository {
  FirestoreOrganizationRepository()
      : super(FirestoreCollectionPath.organizations);

  FirestoreMemberRepository _memberRepository = FirestoreMemberRepository();

  @override
  Future<Organization> find(OrganizationID id) async {
    // Get DB Organization
    DBOrganization dbOrganization =
        DBOrganization.fromMap(await getSingleDocument(id));

    // find creator
    Member creator =
        await _memberRepository.find(MemberID(dbOrganization.creatorID ?? ""));

    // convert to organization
    Organization organization = Organization(
        name: dbOrganization.toName,
        creator: creator,
        id: dbOrganization.toOrganizationID);

    return organization;
  }

  @override
  Future<List<Organization>> findAll() {
    // TODO: implement findAll
    throw UnimplementedError("Organization FindAll");
  }

  @override
  Future<Organization?> findByName(String name) async {
    // pull list of organizations
    List<DBOrganization> organizations = (await getCollectionOfDocuments())
        .map<DBOrganization>(
            (Map<String, dynamic> map) => DBOrganization.fromMap(map))
        .toList();

    // find by name
    for (DBOrganization organization in organizations) {
      if (organization.name == name) {
        return find(OrganizationID(organization.id ?? ""));
      }
    }
    return null;
  }

  @override
  Future<OrganizationID?> insert(String name) async {
    // break components down to DB components
    DBOrganization dbOrganization = DBOrganization(name: name);

    // insert into DB
    String? organizationID = await addDocument(dbOrganization.toMap);

    // update
    dbOrganization.id = organizationID;
    if (await updateDocument(
        dbOrganization.toMap, OrganizationID(dbOrganization.id ?? ""))) {
      return OrganizationID(organizationID ?? "");
    }
    return null;
  }

  @override
  Future<bool> remove(OrganizationID id) {
    return removeDocument(id);
  }

  @override
  Future<bool> update(Organization organization) {
    // convert to DB Organization
    DBOrganization dbOrganization =
        DBOrganization.fromOrganization(organization);

    // update
    return updateDocument(dbOrganization.toMap, organization.id);
  }

  Stream<List<Organization>> allStreamed() {
    return getCollectionOfDocumentsStreamed()
        .asyncMap<List<Organization>>((List<Map<String, dynamic>> maps) async {
      var list =
          maps.map<Future<Organization>>((Map<String, dynamic> map) async {
        DBOrganization dbOrganization = DBOrganization.fromMap(map);
        Member creator =
            await _memberRepository.find(dbOrganization.toCreatorID);

        Organization organization = Organization(
          id: dbOrganization.toOrganizationID,
          creator: creator,
          name: dbOrganization.toName,
        );
        return organization;
      }).toList();

      List<Organization> organizations = [];
      for (Future<Organization> org in list) {
        organizations.add(await org);
      }

      return organizations;
    });
  }

  Stream<Organization> findStreamed(OrganizationID id) {
    return getSingleDocumentStreamed(id)
        .asyncMap<Organization>((Map<String, dynamic>? map) async {
      // convert to DB Organization
      map ?? (throw OrganizationNotFoundError());
      DBOrganization dbOrganization = DBOrganization.fromMap(map);

      // pull out components
      // TODO: Convert to streamed...
      Member creator = await _memberRepository.find(dbOrganization.toCreatorID);

      // create organization
      return Organization(
        name: dbOrganization.toName,
        id: dbOrganization.toOrganizationID,
        creator: creator,
      );
    });
  }
}
