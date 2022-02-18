import 'package:flutter_test/flutter_test.dart';

///
/// test.dart
/// bishopric-assistant
///
/// Created by Po on 9/29/21
/// Copyright 2021 Po. All rights reserved.
///

mixin Test {
  static void fallthrough({String? notes}) {
    String value = "Test entered a failure state";
    if (notes != null) {
      value += ": $notes";
    }
    expect(false, value);
  }
}
