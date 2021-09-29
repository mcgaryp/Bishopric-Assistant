import 'package:models/shared/uuid.dart';

///
/// account_id.dart
/// bishopric-assistant
///
/// Created by Po on 9/28/21
/// Copyright 2021 Po. All rights reserved.
///

class AccountID extends UUID {
  AccountID(String id) : super(id);

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != AccountID) return false;
    return sameValueAs(other as AccountID);
  }

  @override
  bool sameValueAs(UUID other) {
    return this.id == other.id;
  }
}
