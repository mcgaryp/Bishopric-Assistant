import 'package:models/shared/exceptions/for_object_exception.dart';

///
/// assignment_not_found_error.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 1/19/22
/// Copyright 2022 Porter McGary. All rights reserved.
///

class AssignmentNotFoundError extends ForObjectException {
  AssignmentNotFoundError({String? forObject})
      : super("Assignment was not found", forObject: forObject);
}
