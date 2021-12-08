import 'dart:math';

///
/// pin.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 12/3/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

class Pin {
  final DateTime _expiration = DateTime.now().add(Duration(minutes: 10));
  final String _passcode = _generatePin;

  static String get _generatePin {
    String code = "";
    Random random = Random();

    while (code.length != 4) {
      code += random.nextInt(10).toString();
    }

    return code;
  }

  String get passcode => _passcode;

  bool get isExpired => DateTime.now().isAfter(_expiration);

  String get expiration =>
      "${_expiration.month}/${_expiration.day}/${_expiration.year} at "
      "${_expiration.hour}:${_expiration.minute}";

  bool isValid(String pin) => pin == passcode;

  @override
  String toString() {
    return "$passcode expires on $expiration";
  }
}
