import 'package:models/models/account_domain/pin.dart';
import 'package:models/models/account_domain/pin_id.dart';

///
/// pin_repository.dart
/// bishopric-assistant
///
/// Created by Joshua Bee on 3/16/22
/// Copyright 2022 Joshua Bee. All rights reserved.
///

/// [PinRepository] is used for verifying a user's permission to beta test
mixin PinRepository {
  /// [insert] inserts a pin into the database
  Future<bool> insert(Pin pin);

  /// [find] searches for a pin in the database, returns a pin
  Future<Pin?> find(PinID pin);
}
