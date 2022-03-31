import 'package:models/models/organization.dart';

///
/// $FILE_NAME.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 3/18/22
/// Copyright 2022 Porter McGary. All rights reserved.
///

mixin AuthorizationRepository {
  @required
  Future<List<Authorization>> findAll(OrganizationID id);

  @required
  Future<bool> insert(
      Authorization authorization, OrganizationID organizationID);

  @required
  Future<bool> remove(AuthorizationID authorizationID);
}
