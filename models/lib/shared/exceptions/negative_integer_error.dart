import 'package:models/shared/exceptions/for_object_exception.dart';

///
/// negative_integer_error.dart
/// bishopric-assistant
///
/// Created by Po on 9/23/21
/// Copyright 2021 Po. All rights reserved.
///

class NegativeIntegerError extends ForObjectException {
  NegativeIntegerError({String? forObject})
      : super("Integer is negative when it should not be",
            forObject: forObject);
}
