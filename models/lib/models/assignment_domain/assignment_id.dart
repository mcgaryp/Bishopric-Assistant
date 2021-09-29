import 'package:models/shared/uuid.dart';

///
/// assignment_id.dart
/// bishopric-assistant
///
/// Created by Po on 9/25/21
/// Copyright 2021 Po. All rights reserved.
///

class AssignmentID extends UUID {
  AssignmentID(String id) : super(id);

  @override
  bool sameValueAs(UUID other) {
    return this.id == other.id;
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != AssignmentID) return false;
    return sameValueAs(other as AssignmentID);
  }
}
