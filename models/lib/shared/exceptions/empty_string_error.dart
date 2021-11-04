import 'package:models/shared/exceptions/for_object_exception.dart';

///
/// empty_string_error.dart
/// bishopric-assistant
///
/// Created by Po on 9/22/21
/// Copyright 2021 Po. All rights reserved.
///

class EmptyStringError extends ForObjectException {
  EmptyStringError({String? forObject})
      : super("Empty String", forObject: forObject);
}
