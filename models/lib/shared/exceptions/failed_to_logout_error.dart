import 'package:models/shared/exceptions/for_object_exception.dart';

///
/// failed_to_logout_error.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 11/4/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

class FailedToLogoutError extends ForObjectException {
  FailedToLogoutError({String? forObject})
      : super("Failed to Logout", forObject: forObject);
}
