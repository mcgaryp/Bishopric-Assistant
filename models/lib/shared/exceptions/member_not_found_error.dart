///
/// member_not_found_error.dart
/// bishopric-assistant
///
/// Created by Po on 9/29/21
/// Copyright 2021 Po. All rights reserved.
///

class MemberNotFoundError implements Exception {
  final String msg = "Member does not exist";

  @override
  String toString() {
    return msg;
  }
}
