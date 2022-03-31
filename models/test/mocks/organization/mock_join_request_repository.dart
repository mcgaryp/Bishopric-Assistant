import 'package:models/models/organization.dart';

///
/// $FILE_NAME.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 3/17/22
/// Copyright 2022 Porter McGary. All rights reserved.
///

class MockJoinRequestRepository implements JoinRequestRepository {
  @override
  Future<JoinRequest> find(JoinRequestID id) {
    // TODO: implement find
    throw UnimplementedError();
  }

  @override
  Future<bool> insert(JoinRequest joinRequest) {
    // TODO: implement insert
    throw UnimplementedError();
  }

  @override
  Future<bool> remove(JoinRequestID id) {
    // TODO: implement remove
    throw UnimplementedError();
  }

  @override
  Future<List<JoinRequest>> findAll(OrganizationID id) {
    // TODO: implement findAll
    throw UnimplementedError();
  }
}
