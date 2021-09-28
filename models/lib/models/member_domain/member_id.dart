import 'package:models/shared/entity.dart';

///
/// member_id.dart
/// bishopric-assistant
///
/// Created by Po on 9/23/21
/// Copyright 2021 Po. All rights reserved.
///

/// TODO: Implement MemberID, Refer to [ReadMe.md](models/README.md)
/// TODO: Comments
class MemberID extends UUID {
  MemberID(String id) : super(id);
  MemberID.creatorID() : super("Organization Creator");
}
