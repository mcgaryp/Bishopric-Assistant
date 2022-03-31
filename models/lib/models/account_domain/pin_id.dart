import 'package:models/shared/domain_driven_design/entity.dart';

///
/// pin_id.dart
/// bishopric-assistant
///
/// Created by Joshua Bee on 3/16/22
/// Copyright 2022 Joshua Bee. All rights reserved.
///

class PinID extends UUID {
  PinID(String id) : super(id);

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != PinID) return false;
    return sameValueAs(other as PinID);
  }
}
