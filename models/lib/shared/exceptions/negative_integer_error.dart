///
/// negative_integer_error.dart
/// bishopric-assistant
///
/// Created by Po on 9/23/21
/// Copyright 2021 Po. All rights reserved.
///

class NegativeIntegerError implements Exception {
  final String msg = "Integer is negative when it should not be";

  @override
  String toString() {
    return msg;
  }
}
