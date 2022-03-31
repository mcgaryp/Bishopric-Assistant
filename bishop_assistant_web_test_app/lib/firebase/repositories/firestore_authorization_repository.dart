import 'package:bishop_assistant_web_test_app/firebase/firestore_helper.dart';
import 'package:models/models/organization.dart';
import 'package:models/shared/exceptions/exceptions.dart';

///
/// $FILE_NAME.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 3/18/22
/// Copyright 2022 Porter McGary. All rights reserved.
///

class FirestoreAuthorizationRepository extends FirestoreHelper
    implements AuthorizationRepository {
  FirestoreAuthorizationRepository()
      : super(FirestoreCollectionPath.authorizations);

  @override
  Future<List<Authorization>> findAll(OrganizationID id) async {
    // convert to DB Authorization
    List<Authorization> authorizations = (await getCollectionOfDocuments(
            field: DBAuthorization.orgIDKey, isEqualTo: id.id))
        .map<Authorization>((Map<String, dynamic> map) {
      DBAuthorization dbAuthorization = DBAuthorization.fromMap(map);
      return dbAuthorization.toAuthorization;
    }).toList();

    return authorizations;
  }

  @override
  Future<bool> insert(
      Authorization authorization, OrganizationID organizationID) async {
    // convert to DB Authentication
    DBAuthorization dbAuthorization = DBAuthorization.fromAuthorization(
      authorization,
      organizationID,
    );

    // insert
    String? authID = await addDocument(dbAuthorization.toMap);
    authID ?? (throw IdDoesNotExistError(forObject: "DBAuth ID"));
    dbAuthorization.id = authID;

    // update
    return updateDocument(dbAuthorization.toMap, dbAuthorization.toAuthID);
  }

  @override
  Future<bool> remove(AuthorizationID authorizationID) {
    return removeDocument(authorizationID);
  }
}
