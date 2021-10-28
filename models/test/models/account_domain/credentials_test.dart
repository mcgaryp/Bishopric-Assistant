import 'package:flutter_test/flutter_test.dart';
import 'package:models/models/account.dart';
import 'package:models/shared/exceptions.dart';
import 'package:models/shared/test.dart';

import '../../mocks/account/mock_credentials.dart';

///
/// credentials_test.dart
/// bishopric-assistant
///
/// Created by Po on 9/29/21
/// Copyright 2021 Po. All rights reserved.
///

class CredentialsTest with Test {
  static void shouldReturnValidUsernameWhenValidUsername() {
    Credentials credentials = MockCredentials().credentials;
    String result = credentials.username;
    expect(result, MockCredentials.mockUsername);
  }

  static void shouldReturnValidPasswordWhenValidPassword() {
    Credentials credentials = MockCredentials().credentials;
    String result = credentials.password;
    expect(result, MockCredentials.mockPassword);
  }

  static void shouldReturnEmptyStringErrorWhenInvalidPassword() {
    try {
      MockCredentials(password: "");
    } catch (result) {
      expect(result.toString(), EmptyStringError().toString());
      return;
    }
    Test.fallthrough;
  }

  static void shouldReturnEmptyStringErrorWhenInvalidUsername() {
    try {
      MockCredentials(username: "");
    } catch (result) {
      expect(result.toString(), EmptyStringError().toString());
      return;
    }
    Test.fallthrough;
  }
}

runCredentialsTests() {
  group("Credentials", () {
    test("should return username",
        CredentialsTest.shouldReturnValidUsernameWhenValidUsername);
    test("should return password",
        CredentialsTest.shouldReturnValidPasswordWhenValidPassword);
    test("should return empty string error when invalid password",
        CredentialsTest.shouldReturnEmptyStringErrorWhenInvalidPassword);
    test("should return empty string error when invalid username",
        CredentialsTest.shouldReturnEmptyStringErrorWhenInvalidUsername);
  });
}
