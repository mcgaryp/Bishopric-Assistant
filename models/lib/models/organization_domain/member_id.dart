import 'package:models/shared/uuid.dart';

///
/// member_id.dart
/// bishopric-assistant
///
/// Created by Po on 9/23/21
/// Copyright 2021 Po. All rights reserved.
///

/// [MemberID] model to represent an individual member identifier
class MemberID extends UUID {
  MemberID(String id) : super(id);

  MemberID.creatorID() : super("Organization Creator");

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != MemberID) return false;
    return sameValueAs(other as MemberID);
  }
}
