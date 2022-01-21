import 'package:models/shared/exceptions/for_object_exception.dart';

///
/// invalid_date_error.dart
/// bishopric-assistant
///
/// Created by Joshua Bee on 1/19/22
/// Copyright 2022 Joshua Bee. All rights reserved.
///

class InvalidDateError extends ForObjectException {
  InvalidDateError({String? forObject})
      : super("Invalid Date", forObject: forObject);
}
