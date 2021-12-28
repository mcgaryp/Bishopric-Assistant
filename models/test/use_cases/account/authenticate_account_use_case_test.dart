import 'package:flutter_test/flutter_test.dart';
import 'package:models/shared/test.dart';

///
/// authenticate_account_use_case_test.dart
/// bishopric-assistant
///
/// Created by Po on 10/3/21
/// Copyright 2021 Po. All rights reserved.
///

class AuthenticateAccountUseCaseTest with Test {
  static void shouldReturnValidResultWhenValidCredentials() async {
    throw UnimplementedError();
  }

  static void shouldReturnInvalidResultWhenInValidUsername() async {
    throw UnimplementedError();
  }

  static void shouldReturnInvalidResultWhenInValidPassword() async {
    throw UnimplementedError();
  }
}

runAuthenticateAccountTests() {
  group("Account Authentication", () {
    test(
        "should return an account",
        AuthenticateAccountUseCaseTest
            .shouldReturnValidResultWhenValidCredentials);
    test(
        "should return an incorrect username error",
        AuthenticateAccountUseCaseTest
            .shouldReturnInvalidResultWhenInValidUsername);
    test(
        "should return an incorrect password error",
        AuthenticateAccountUseCaseTest
            .shouldReturnInvalidResultWhenInValidPassword);
  });
}
