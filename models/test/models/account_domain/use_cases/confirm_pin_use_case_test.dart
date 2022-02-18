import 'package:flutter_test/flutter_test.dart';

///
/// confirm_pin_use_case_test.dart
///
///
/// Created by Porter McGary on 10/27/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

// TODO: Should this class still exist?
class ConfirmPinUseCaseTest {
  // REPO FUNCTION CALLS
  // - uses state repo
  //   - calls find
  static void verifyFunctionRepoCalls() {
    // throw UnimplementedError();
  }

  // TODO: VERIFY PERMISSIONS ?
  static void verifyPermissions() async {
    // throw UnimplementedError();
  }

  // TODO: VERIFY RESULTS ?
  static void verifyResults() async {
    // throw UnimplementedError();
  }
}

runConfirmPinUseCaseTests() {
  group("Confirm Pin Use Case Tests", () {
    test("Verify repo function calls",
        ConfirmPinUseCaseTest.verifyFunctionRepoCalls);
    test("verify permissions", ConfirmPinUseCaseTest.verifyPermissions);
    test("verify results", ConfirmPinUseCaseTest.verifyResults);
  });
}
