import 'package:flutter_test/flutter_test.dart';
import 'package:models/models/role.dart';
import 'package:models/models/user.dart';
import 'package:models/shared/exceptions.dart';

import '../../mocks/mock_member_user.dart';

///
/// member_user_test.dart
/// bishopric-assistant
///
/// Created by porter on 9/28/21
/// Copyright 2021 porter. All rights reserved.
///

class MemberUserTest {
  static void shouldReturnFirstNameWhenValidFirstName() {
    MemberUser user = MockMemberUser(first: "Test").user;
    String result = user.firstName;
    expect(result, "Test");
  }

  static shouldReturnEmptyStringErrorWhenInvalidFirstName() {
    try {
      MockMemberUser(first: "");
    } catch (result) {
      expect(result.toString(), EmptyStringError().toString());
      return;
    }
    checkFallThrough;
  }

  static void shouldReturnLastNameWhenValidLastName() {
    MemberUser user = MockMemberUser(last: "Test").user;
    String result = user.lastName;
    expect(result, "Test");
  }

  static void shouldReturnEmptyStringErrorWhenInvalidLastName() {
    try {
      MockMemberUser(last: "");
    } catch (result) {
      expect(result.toString(), EmptyStringError().toString());
      return;
    }
    checkFallThrough;
  }

  static void shouldReturnNameWhenValidName() {
    MemberUser user = MockMemberUser(first: "Mock", last: "Test").user;
    String result = user.name;
    expect(result, "Mock Test");
  }

  static void shouldReturnEmptyStringErrorWhenInvalidLastNameForName() {
    try {
      MockMemberUser(last: "").user.name;
    } catch (result) {
      expect(result.toString(), EmptyStringError().toString());
      return;
    }
    checkFallThrough;
  }

  static void shouldReturnEmptyStringErrorWhenInvalidFirstNameForName() {
    try {
      MockMemberUser(first: "").user.name;
    } catch (result) {
      expect(result.toString(), EmptyStringError().toString());
      return;
    }
    checkFallThrough;
  }

  static void shouldReturnEmptyStringErrorWhenInvalidFirstAndLastNameForName() {
    try {
      MockMemberUser(first: "", last: "").user.name;
    } catch (result) {
      expect(result.toString(), EmptyStringError().toString());
      return;
    }
    checkFallThrough;
  }

  static void shouldReturnPhoneWhenValidPhone() {
    MemberUser user = MockMemberUser(phone: "Test").user;
    String result = user.phone;
    expect(result, "Test");
  }

  static void shouldReturnEmptyStringErrorWhenInvalidPhone() {
    try {
      MockMemberUser(phone: "");
    } catch (result) {
      expect(result.toString(), EmptyStringError().toString());
      return;
    }
    checkFallThrough;
  }

  static void shouldReturnEmailWhenValidEmail() {
    MemberUser user = MockMemberUser(email: "Test").user;
    String result = user.email;
    expect(result, "Test");
  }

  static void shouldReturnEmptyStringErrorWhenInvalidEmail() {
    try {
      MockMemberUser(email: "");
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
    MemberUser user = MockMemberUser(role: role).user;
    Role result = user.role;
    expect(result, role);
  }

  static void get checkFallThrough => expect(true, "Fell Through Catch");
}

runMemberUserTests() {
  group("Member User Tests", () {
    test("should return valid first name",
        MemberUserTest.shouldReturnFirstNameWhenValidFirstName);
    test("should return empty string error when empty first name",
        MemberUserTest.shouldReturnEmptyStringErrorWhenInvalidFirstName);
    test("should return valid last name",
        MemberUserTest.shouldReturnLastNameWhenValidLastName);
    test("should return empty string error when empty last name",
        MemberUserTest.shouldReturnEmptyStringErrorWhenInvalidLastName);
    test("should return valid name when valid last and first names",
        MemberUserTest.shouldReturnNameWhenValidName);
    test(
        "should return empty string error when empty first name and calling name",
        MemberUserTest.shouldReturnEmptyStringErrorWhenInvalidFirstNameForName);
    test(
        "should return empty string error when empty last name and calling name",
        MemberUserTest.shouldReturnEmptyStringErrorWhenInvalidLastNameForName);
    test(
        "should return empty string error when empty first and last name and calling name",
        MemberUserTest
            .shouldReturnEmptyStringErrorWhenInvalidFirstAndLastNameForName);
    test("should return valid phone",
        MemberUserTest.shouldReturnPhoneWhenValidPhone);
    test("should return empty string error when empty phone",
        MemberUserTest.shouldReturnEmptyStringErrorWhenInvalidPhone);
    test("should return valid email",
        MemberUserTest.shouldReturnEmailWhenValidEmail);
    test("should return empty string error when empty email",
        MemberUserTest.shouldReturnEmptyStringErrorWhenInvalidEmail);
    test("should return valid role",
        MemberUserTest.shouldReturnRoleWhenValidRole);
  });
}
