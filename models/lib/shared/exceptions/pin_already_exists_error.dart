import 'package:models/shared/exceptions/for_object_exception.dart';

///
/// pin_already_exists_error.dart
/// bishopric-assistant
///
/// Created by Joshua Bee on 3/17/22
/// Copyright 2022 Joshua Bee. All rights reserved.
///

class PinAlreadyExistsError extends ForObjectException {
  PinAlreadyExistsError({String? forObject})
      : super("Pin already exists", forObject: forObject);
}
