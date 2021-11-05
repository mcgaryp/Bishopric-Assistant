import 'package:flutter_test/flutter_test.dart';

import 'exceptions/empty_string_exception_test.dart';
import 'exceptions/failed_to_login_error_test.dart';
import 'exceptions/failed_to_logout_error_test.dart';
import 'exceptions/negative_integer_error_test.dart';
import 'serializable_test.dart';
import 'uuid_test.dart';

///
/// shared_test.dart
/// bishopric-assistant
///
/// Created by Po on 9/29/21
/// Copyright 2021 Po. All rights reserved.
///

runSharedTests() {
  group("Shared Tests", () {
    group("DDD", () {});
    group("Exceptions", () {
      runEmptyStringExceptionTest();
      runFailedToLoginErrorTests();
      runFailedToLogoutErrorTests();
      runNegativeIntegerErrorTests();
    });
    group("Specifications", () {});
    runSerializableTests();
    runUUIDTests();
  });
}
