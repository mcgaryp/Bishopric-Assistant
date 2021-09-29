import 'package:models/shared/uuid.dart';

///
/// event_id.dart
/// bishopric-assistant
///
/// Created by Po on 9/25/21
/// Copyright 2021 Po. All rights reserved.
///

class EventID extends UUID {
  EventID(String id) : super(id);

  @override
  bool sameValueAs(UUID other) {
    return other.id == this.id;
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != EventID) return false;
    return sameValueAs(other as EventID);
  }
}
