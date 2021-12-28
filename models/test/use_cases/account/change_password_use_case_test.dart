import 'package:flutter_test/flutter_test.dart';

///
/// change_password_use_case_test.dart
/// bishopric-assistant
///
/// Created by Po on 10/3/21
/// Copyright 2021 Po. All rights reserved.
///

class ChangePasswordUseCaseTest {
  static void
      shouldReturnValidResultWhenValidAccountIDAndPasswordGiven() async {
    throw UnimplementedError();
  }

  static void
      shouldReturnAccountNotFoundErrorWhenInvalidAccountIDGiven() async {
    throw UnimplementedError();
  }
}

runChangePasswordUseCaseTests() {
  group("Change Password Use Case", () {
    test(
        "should return valid result when account id and password are given",
        ChangePasswordUseCaseTest
            .shouldReturnValidResultWhenValidAccountIDAndPasswordGiven);
    test(
        "should return Account not Found Error when bad account ID given",
        ChangePasswordUseCaseTest
            .shouldReturnAccountNotFoundErrorWhenInvalidAccountIDGiven);
  });
}
