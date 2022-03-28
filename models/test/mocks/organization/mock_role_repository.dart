import 'package:models/models/organization.dart';

///
/// $FILE_NAME.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 3/19/22
/// Copyright 2022 Porter McGary. All rights reserved.
///

class MockRoleRepository implements RoleRepository {
  @override
  Future<Role> find(RoleID id, OrganizationID organizationID) {
    // TODO: implement find
    throw UnimplementedError("Role Find");
  }

  @override
  Future<RoleID?> insert(Role role, OrganizationID organizationID) {
    // TODO: implement insert
    throw UnimplementedError("Role Insert");
  }
}
