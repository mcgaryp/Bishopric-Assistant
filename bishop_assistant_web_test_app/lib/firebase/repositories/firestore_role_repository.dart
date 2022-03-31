import 'package:bishop_assistant_web_test_app/firebase/firestore_helper.dart';
import 'package:bishop_assistant_web_test_app/firebase/repositories/repositories.dart';
import 'package:models/models/organization.dart';
import 'package:models/util/extensions/authorization_list_extension.dart';

///
/// $FILE_NAME.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 3/18/22
/// Copyright 2022 Porter McGary. All rights reserved.
///

class FirestoreRoleRepository extends FirestoreHelper
    implements RoleRepository {
  FirestoreRoleRepository() : super(FirestoreCollectionPath.roles);

  @override
  Future<Role> find(RoleID id, OrganizationID orgID) async {
    // convert to DB Role
    DBRole dbRole = DBRole.fromMap(await getSingleDocument(id));

    // find Authorization
    FirestoreAuthorizationRepository authorizationRepository =
        FirestoreAuthorizationRepository();
    List<Authorization> authorizations =
        await authorizationRepository.findAll(orgID);
    Authorization authorization =
        authorizations.find(int.parse(dbRole.toAuthorizationID));

    // convert to role
    Role role = Role(
        id: dbRole.toRoleID, authorization: authorization, name: dbRole.toName);
    return role;
  }

  @override
  Future<RoleID?> insert(Role role, OrganizationID organizationID) async {
    // convert to DB Role
    DBRole dbRole = DBRole(
      organizationID: organizationID.id,
      name: role.name,
      authorizationID: role.authorization.rank.toString(),
    );

    // insert
    String? roleID = await addDocument(dbRole.toMap);

    // update role
    dbRole.roleID = roleID;
    if (await updateDocument(dbRole.toMap, dbRole.toRoleID))
      return dbRole.toRoleID;
    return null;
  }

  Future<List<Role>> findAll(OrganizationID id) async {
    List<Future<Role>> futures = (await getCollectionOfDocuments(
            field: DBRole.organizationIDKey, isEqualTo: id.id))
        .map<Future<Role>>((Map<String, dynamic> map) async {
      DBRole dbRole = DBRole.fromMap(map);
      return await find(dbRole.toRoleID, id);
    }).toList();

    List<Role> roles = [];
    for (Future<Role> future in futures) {
      roles.add(await future);
    }

    return roles;
  }

  @override
  Future<bool> remove(RoleID roleID) {
    return removeDocument(roleID);
  }
}
