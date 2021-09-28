import 'package:models/shared/entity.dart';

///
/// role_id.dart
/// bishopric-assistant
///
/// Created by Po on 9/23/21
/// Copyright 2021 Po. All rights reserved.
///

/// TODO: Implement RoleID, Refer to [ReadMe.md](models/README.md)
/// TODO: Comments
@Deprecated("No longer in use")
class RoleID extends UUID {
  RoleID(String id) : super(id);

  RoleID.creatorID() : super("Creator Role") {}
}
