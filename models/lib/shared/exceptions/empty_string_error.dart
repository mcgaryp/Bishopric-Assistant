///
/// empty_string_error.dart
/// bishopric-assistant
///
/// Created by Po on 9/22/21
/// Copyright 2021 Po. All rights reserved.
///

class EmptyStringError implements Exception {
  final String msg = "Empty String";

  @override
  String toString() {
    return msg;
  }
}