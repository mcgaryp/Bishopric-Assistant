import 'package:flutter_test/flutter_test.dart';
import 'package:models/models/role.dart';
import 'package:models/models/user.dart';
import 'package:models/shared/exceptions.dart';

import '../../mocks/mock_current_user.dart';

///
/// current_user_test.dart
/// bishopric-assistant
///
/// Created by porter on 9/28/21
/// Copyright 2021 porter. All rights reserved.
///

class CurrentUserTest {
  static void shouldReturnFirstNameWhenValidFirstName() {
    CurrentUser user = MockCurrentUser(first: "Test").user;
    String result = user.firstName;
    expect(result, "Test");
  }

  static shouldReturnEmptyStringErrorWhenInvalidFirstName() {
    try {
      MockCurrentUser(first: "");
    } catch (result) {
      expect(result.toString(), EmptyStringError().toString());
      return;
    }
    checkFallThrough;
  }

  static void shouldReturnLastNameWhenValidLastName() {
    CurrentUser user = MockCurrentUser(last: "Test").user;
    String result = user.lastName;
    expect(result, "Test");
  }

  static void shouldReturnEmptyStringErrorWhenInvalidLastName() {
    try {
      MockCurrentUser(last: "");
    } catch (result) {
      expect(result.toString(), EmptyStringError().toString());
      return;
    }
    checkFallThrough;
  }

  static void shouldReturnNameWhenValidName() {
    CurrentUser user = MockCurrentUser(first: "Mock", last: "Test").user;
    String result = user.name;
    expect(result, "Mock Test");
  }

  static void shouldReturnEmptyStringErrorWhenInvalidLastNameForName() {
    try {
      MockCurrentUser(last: "").user.name;
    } catch (result) {
      expect(result.toString(), EmptyStringError().toString());
      return;
    }
    checkFallThrough;
  }

  static void shouldReturnEmptyStringErrorWhenInvalidFirstNameForName() {
    try {
      MockCurrentUser(first: "").user.name;
    } catch (result) {
      expect(result.toString(), EmptyStringError().toString());
      return;
    }
    checkFallThrough;
  }

  static void shouldReturnEmptyStringErrorWhenInvalidFirstAndLastNameForName() {
    try {
      MockCurrentUser(first: "", last: "").user.name;
    } catch (result) {
      expect(result.toString(), EmptyStringError().toString());
      return;
    }
    checkFallThrough;
  }

  static void shouldReturnPhoneWhenValidPhone() {
    CurrentUser user = MockCurrentUser(phone: "Test").user;
    String result = user.phone;
    expect(result, "Test");
  }

  static void shouldReturnEmptyStringErrorWhenInvalidPhone() {
    try {
      MockCurrentUser(phone: "");
    } catch (result) {
      expect(result.toString(), EmptyStringError().toString());
      return;
    }
    checkFallThrough;
  }

  static void shouldReturnEmailWhenValidEmail() {
    CurrentUser user = MockCurrentUser(email: "Test").user;
    String result = user.email;
    expect(result, "Test");
  }

  static void shouldReturnEmptyStringErrorWhenInvalidEmail() {
    try {
      MockCurrentUser(email: "");
    } catch (result) {
      expect(result.toString(), EmptyStringError().toString());
      return;
    }
    checkFallThrough;
  }

  static void shouldReturnUsernameWhenValidUsername() {
    CurrentUser user = MockCurrentUser(username: "Test").user;
    String result = user.username;
    expect(result, "Test");
  }

  static void shouldReturnEmptyStringErrorWhenInvalidUsername() {
    try {
      MockCurrentUser(username: "");
    } catch (result) {
      expect(result.toString(), EmptyStringError().toString());
      return;
    }
    checkFallThrough;
  }

  static void shouldReturnPasswordWhenValidPassword() {
    CurrentUser user = MockCurrentUser(password: "Test").user;
    String result = user.password;
    expect(result, "Test");
  }

  static void shouldReturnEmptyStringErrorWhenInvalidPassword() {
    try {
      MockCurrentUser(password: "");
    } catch (result) {
      expect(result.toString(), EmptyStringError().toString());
      return;
    }
    checkFallThrough;
  }

  static void shouldReturnRoleWhenValidRole() {
    Role role = Role(
        id: RoleID("Test Role"),
        securityClearance: SecurityClearance.level1,
        name: "Test Role");
    CurrentUser user = MockCurrentUser(role: role).user;
    Role result = user.role;
    expect(result, role);
  }

  static void shouldReturnPrivilegesWhenValidPrivileges() {
    Privileges privileges = Privileges(true, true, true);
    CurrentUser user = MockCurrentUser(privileges: privileges).user;
    Privileges result = user.privileges;
    expect(result, privileges);
  }

  static void get checkFallThrough => expect(true, "Fell Through Catch");
}

runCurrentUserTests() {
  group("Member User Tests", () {
    test("should return valid first name",
        CurrentUserTest.shouldReturnFirstNameWhenValidFirstName);
    test("should return empty string error when empty first name",
        CurrentUserTest.shouldReturnEmptyStringErrorWhenInvalidFirstName);
    test("should return valid last name",
        CurrentUserTest.shouldReturnLastNameWhenValidLastName);
    test("should return empty string error when empty last name",
        CurrentUserTest.shouldReturnEmptyStringErrorWhenInvalidLastName);
    test("should return valid name when valid last and first names",
        CurrentUserTest.shouldReturnNameWhenValidName);
    test(
        "should return empty string error when empty first name and calling name",
        CurrentUserTest
            .shouldReturnEmptyStringErrorWhenInvalidFirstNameForName);
    test(
        "should return empty string error when empty last name and calling name",
        CurrentUserTest.shouldReturnEmptyStringErrorWhenInvalidLastNameForName);
    test(
        "should return empty string error when empty first and last name and calling name",
        CurrentUserTest
            .shouldReturnEmptyStringErrorWhenInvalidFirstAndLastNameForName);
    test("should return valid phone",
        CurrentUserTest.shouldReturnPhoneWhenValidPhone);
    test("should return empty string error when empty phone",
        CurrentUserTest.shouldReturnEmptyStringErrorWhenInvalidPhone);
    test("should return valid email",
        CurrentUserTest.shouldReturnEmailWhenValidEmail);
    test("should return empty string error when empty email",
        CurrentUserTest.shouldReturnEmptyStringErrorWhenInvalidEmail);
    test("should return valid username",
        CurrentUserTest.shouldReturnUsernameWhenValidUsername);
    test("should return empty string error when empty username",
        CurrentUserTest.shouldReturnEmptyStringErrorWhenInvalidUsername);
    test("should return valid password",
        CurrentUserTest.shouldReturnPasswordWhenValidPassword);
    test("should return empty string error when empty password",
        CurrentUserTest.shouldReturnEmptyStringErrorWhenInvalidPassword);
    test("should return valid role",
        CurrentUserTest.shouldReturnRoleWhenValidRole);
    test("should return valid privileges",
        CurrentUserTest.shouldReturnPrivilegesWhenValidPrivileges);
  });
}
