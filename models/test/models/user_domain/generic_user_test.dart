import 'package:flutter_test/flutter_test.dart';
import 'package:models/models/user.dart';
import 'package:models/shared/exceptions.dart';

import '../../mocks/mock_generic_user.dart';

///
/// generic_user_test.dart
/// bishopric-assistant
///
/// Created by porter on 9/27/21
/// Copyright 2021 porter. All rights reserved.
///

class GenericUserTest {
  static void shouldReturnFirstNameWhenValidFirstName() {
    GenericUser user = MockGenericUser(first: "Test").user;
    String result = user.firstName;
    expect(result, "Test");
  }

  static shouldReturnEmptyStringErrorWhenInvalidFirstName() {
    try {
      MockGenericUser(first: "");
    } catch (result) {
      expect(result.toString(), EmptyStringError().toString());
      return;
    }
    checkFallThrough;
  }

  static void shouldReturnLastNameWhenValidLastName() {
    GenericUser user = MockGenericUser(last: "Test").user;
    String result = user.lastName;
    expect(result, "Test");
  }

  static void shouldReturnEmptyStringErrorWhenInvalidLastName() {
    try {
      MockGenericUser(last: "");
    } catch (result) {
      expect(result.toString(), EmptyStringError().toString());
      return;
    }
    checkFallThrough;
  }

  static void shouldReturnNameWhenValidName() {
    GenericUser user = MockGenericUser(first: "Mock", last: "Test").user;
    String result = user.name;
    expect(result, "Mock Test");
  }

  static void shouldReturnEmptyStringErrorWhenInvalidLastNameForName() {
    try {
      MockGenericUser(last: "").user.name;
    } catch (result) {
      expect(result.toString(), EmptyStringError().toString());
      return;
    }
    checkFallThrough;
  }

  static void shouldReturnEmptyStringErrorWhenInvalidFirstNameForName() {
    try {
      MockGenericUser(first: "").user.name;
    } catch (result) {
      expect(result.toString(), EmptyStringError().toString());
      return;
    }
    checkFallThrough;
  }

  static void shouldReturnEmptyStringErrorWhenInvalidFirstAndLastNameForName() {
    try {
      MockGenericUser(first: "", last: "").user.name;
    } catch (result) {
      expect(result.toString(), EmptyStringError().toString());
      return;
    }
    checkFallThrough;
  }

  static void shouldReturnUsernameWhenValidUsername() {
    GenericUser user = MockGenericUser(username: "Test").user;
    String result = user.username;
    expect(result, "Test");
  }

  static void shouldReturnEmptyStringErrorWhenInvalidUsername() {
    try {
      MockGenericUser(username: "");
    } catch (result) {
      expect(result.toString(), EmptyStringError().toString());
      return;
    }
    checkFallThrough;
  }

  static void shouldReturnPasswordWhenValidPassword() {
    GenericUser user = MockGenericUser(password: "Test").user;
    String result = user.password;
    expect(result, "Test");
  }

  static void shouldReturnEmptyStringErrorWhenInvalidPassword() {
    try {
      MockGenericUser(password: "");
    } catch (result) {
      expect(result.toString(), EmptyStringError().toString());
      return;
    }
    checkFallThrough;
  }

  static void get checkFallThrough => expect(true, "Fell Through Catch");
}

runGenericUserTests() {
  group("Generic User Tests", () {
    test("should return valid first name",
        GenericUserTest.shouldReturnFirstNameWhenValidFirstName);
    test("should return empty string error when empty first name",
        GenericUserTest.shouldReturnEmptyStringErrorWhenInvalidFirstName);
    test("should return valid last name",
        GenericUserTest.shouldReturnLastNameWhenValidLastName);
    test("should return empty string error when empty last name",
        GenericUserTest.shouldReturnEmptyStringErrorWhenInvalidLastName);
    test("should return valid name when valid last and first names",
        GenericUserTest.shouldReturnNameWhenValidName);
    test(
        "should return empty string error when empty first name and calling name",
        GenericUserTest
            .shouldReturnEmptyStringErrorWhenInvalidFirstNameForName);
    test(
        "should return empty string error when empty last name and calling name",
        GenericUserTest.shouldReturnEmptyStringErrorWhenInvalidLastNameForName);
    test(
        "should return empty string error when empty first and last name and calling name",
        GenericUserTest
            .shouldReturnEmptyStringErrorWhenInvalidFirstAndLastNameForName);
    test("should return valid username",
        GenericUserTest.shouldReturnUsernameWhenValidUsername);
    test("should return empty string error when empty username",
        GenericUserTest.shouldReturnEmptyStringErrorWhenInvalidUsername);
    test("should return valid password",
        GenericUserTest.shouldReturnPasswordWhenValidPassword);
    test("should return empty string error when empty password",
        GenericUserTest.shouldReturnEmptyStringErrorWhenInvalidPassword);
  });
}
