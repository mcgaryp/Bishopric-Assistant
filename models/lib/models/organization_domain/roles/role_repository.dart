import 'package:models/models/organization.dart';

///
/// $FILE_NAME.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 3/18/22
/// Copyright 2022 Porter McGary. All rights reserved.
///

mixin RoleRepository {
  @required
  Future<Role> find(RoleID id, OrganizationID orgID);

  @required
  Future<RoleID?> insert(Role role, OrganizationID organizationID);

  @required
  Future<bool> remove(RoleID roleID);

  @required
  Future<List<Role>> findAll(OrganizationID organizationID);
}
