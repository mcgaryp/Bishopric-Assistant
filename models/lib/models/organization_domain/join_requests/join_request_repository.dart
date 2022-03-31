import 'package:models/models/organization.dart';

///
/// $FILE_NAME.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 3/17/22
/// Copyright 2022 Porter McGary. All rights reserved.
///

mixin JoinRequestRepository {
  @required
  Future<List<JoinRequest>> findAll(OrganizationID id);

  @required
  Future<JoinRequest> find(JoinRequestID id);

  @required
  Future<bool> insert(JoinRequest joinRequest);

  @required
  Future<bool> remove(JoinRequestID id);
}
