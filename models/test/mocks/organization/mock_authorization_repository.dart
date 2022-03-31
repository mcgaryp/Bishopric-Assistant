import 'package:models/models/organization.dart';

///
/// $FILE_NAME.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 3/19/22
/// Copyright 2022 Porter McGary. All rights reserved.
///

class MockAuthorizationRepository implements AuthorizationRepository {
  @override
  Future<List<Authorization>> findAll(OrganizationID id) {
    // TODO: implement findAll
    throw UnimplementedError("Authorization FindAll");
  }

  @override
  Future<bool> insert(
      Authorization authorization, OrganizationID organizationID) {
    // TODO: implement insert
    throw UnimplementedError();
  }

  @override
  Future<bool> remove(AuthorizationID authorizationID) {
    // TODO: implement remove
    throw UnimplementedError();
  }
}
