import 'package:models/shared/entity.dart';

///
/// role.dart
/// bishopric-assistant
///
/// Created by Po on 9/22/21
/// Copyright 2021 Po. All rights reserved.
///

// TODO: This is to specific how to make it more generic...?
// eventually we want creators of Organizations to create the roles and set the
// security levels
class Role extends Entity<Role> {
  Role(UUID id) : super(id);

  @override
  bool sameIdentityAs(other) {
    // TODO: implement sameIdentityAs
    throw UnimplementedError();
  }

}
