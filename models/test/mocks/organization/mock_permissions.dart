import 'package:models/models/organization_domain/permissions.dart';

///
/// mock_permissions.dart
/// bishopric-assistant
///
/// Created by Joshua Bee on 2/10/22
/// Copyright 2022 Joshua Bee. All rights reserved.
///

class MockPermissions {
  static Permissions mockPermissions = Permissions.Creator;
  late final Permissions permissions;

  MockPermissions({Permissions? permissions}) {
    this.permissions = permissions ?? mockPermissions;
  }
}
