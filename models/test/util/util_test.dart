import 'package:flutter_test/flutter_test.dart';

import 'extensions/string_extensions_test.dart';

///
/// util_test.dart
/// bishopric-assistant
///
/// Created by Po on 9/29/21
/// Copyright 2021 Po. All rights reserved.
///

runUtilTests() {
  group("Util Tests", () {
    group("Extensions", () {
      runStringExtensionTests();
    });
  });
}
