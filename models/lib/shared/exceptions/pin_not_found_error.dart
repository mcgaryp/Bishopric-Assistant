import 'package:models/shared/exceptions/for_object_exception.dart';

///
/// pin_not_found_error.dart
/// bishopric-assistant
///
/// Created by Joshua Bee on 3/17/22
/// Copyright 2022 Joshua Bee. All rights reserved.
///

class PinNotFoundError extends ForObjectException {
  PinNotFoundError({String? forObject})
      : super("Pin was not found", forObject: forObject);
}
