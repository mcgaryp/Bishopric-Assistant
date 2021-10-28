import 'package:flutter_test/flutter_test.dart';

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
    group("Exceptions", () {});
    group("Specifications", () {});
    runSerializableTests();
    runUUIDTests();
  });
}
