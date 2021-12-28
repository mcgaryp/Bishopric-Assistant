import 'package:flutter_test/flutter_test.dart';

///
/// recover_account_use_case_test.dart
/// bishopric-assistant
///
/// Created by Po on 10/3/21
/// Copyright 2021 Po. All rights reserved.
///

/// TODO: Split into Two Use cases request and recover
class RecoverAccountUseCaseTest {
  static final Duration duration = Duration(seconds: 1);

  static void shouldReturnAccountWhenValidUsernameGiven() async {
    throw UnimplementedError();
  }

  static void shouldReturnAccountWhenValidPhoneGiven() async {
    throw UnimplementedError();
  }

  static void shouldReturnAccountNotFoundErrorWhenInvalidUsernameGiven() async {
    throw UnimplementedError();
  }

  static void shouldReturnAccountNotFoundErrorWhenInvalidPhoneGiven() async {
    throw UnimplementedError();
  }
}

runRecoverAccountUseCaseTest() {
  group("Recover Account", () {
    test(
        "should return account when valid username is given with valid secondary authentication",
        RecoverAccountUseCaseTest.shouldReturnAccountWhenValidUsernameGiven);
    test(
        "should return account when valid phone is given with valid secondary authentication",
        RecoverAccountUseCaseTest.shouldReturnAccountWhenValidPhoneGiven);
    test(
        "should return Account Not Found Error when invalid username given",
        RecoverAccountUseCaseTest
            .shouldReturnAccountNotFoundErrorWhenInvalidUsernameGiven);
    test(
        "should return Account Not Found Error when invalid phone given",
        RecoverAccountUseCaseTest
            .shouldReturnAccountNotFoundErrorWhenInvalidPhoneGiven);
  });
}
