import 'package:flutter_test/flutter_test.dart';
import 'package:models/models/account_domain/pin.dart';

///
/// pin_test.dart
///
///
/// Created by Porter McGary on 12/3/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

class PinTest {
  static shouldReturnValidPin() {
    Pin pin = Pin();
    String passcode = pin.passcode;
    expect(passcode, pin.passcode);
    expect(pin.passcode, pin.passcode);
    expect(pin.isValid(passcode), true);
    expect(pin.isValid("abcd"), false);
    String changedPin = passcode.substring(0, 3) +
        (int.parse(passcode.substring(3)) + 1).toString();
    expect(pin.isValid(changedPin), false);
    print(pin.expiration);
  }
}

runPinTests() {
  test("Pin Tests", PinTest.shouldReturnValidPin);
}
