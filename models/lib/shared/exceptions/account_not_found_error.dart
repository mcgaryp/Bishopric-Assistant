///
/// account_not_found_error.dart
/// bishopric-assistant
///
/// Created by Po on 9/29/21
/// Copyright 2021 Po. All rights reserved.
///

class AccountNotFoundError implements Exception {
  final String msg = "Account does not exist";

  @override
  String toString() {
    return msg;
  }
}
