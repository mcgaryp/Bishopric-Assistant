import 'package:models/shared/entity.dart';

///
/// user_id.dart
/// bishopric-assistant
///
/// Created by Po on 9/23/21
/// Copyright 2021 Po. All rights reserved.
///

/// TODO: Implement UserID, Refer to [ReadMe.md](models/README.md)
/// TODO: Comments
///
@Deprecated("Use Accounts")
class UserID extends UUID {
  UserID(String id) : super(id);
}
