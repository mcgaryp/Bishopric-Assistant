///
/// account_already_exists_error.dart
/// bishopric-assistant
///
/// Created by Po on 9/29/21
/// Copyright 2021 Po. All rights reserved.
///

class AccountAlreadyExistsError implements Exception {
  final String msg = "Account Already Exists";

  @override
  String toString() {
    return msg;
  }
}
