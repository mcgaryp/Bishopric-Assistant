import 'package:flutter_test/flutter_test.dart';
import 'package:models/models/account.dart';
import 'package:models/shared/exceptions.dart';
import 'package:models/shared/test.dart';

import '../../mocks/account/mock_name.dart';

///
/// name_test.dart
/// bishopric-assistant
///
/// Created by Po on 9/29/21
/// Copyright 2021 Po. All rights reserved.
///

class NameTest with Test {
  static void shouldReturnValidFirstNameWhenValidNameGiven() {
    Name name = MockName(first: "Mock").name;
    String result = name.first;
    expect(result, "Mock");
  }

  static void shouldReturnValidCapitalizedFirstNameWhenValidNameGiven() {
    Name name = MockName(first: "mock").name;
    String result = name.first;
    expect(result, "Mock");
  }

  static void shouldReturnValidLastNameWhenValidNameGiven() {
    Name name = MockName(last: "Mock").name;
    String result = name.last;
    expect(result, "Mock");
  }

  static void shouldReturnValidCapitalizedLastNameWhenValidNameGiven() {
    Name name = MockName(last: "mock").name;
    String result = name.last;
    expect(result, "Mock");
  }

  static void shouldReturnValidNameWhenValidFirstName() {
    Name name = MockName(first: "First").name;
    String result = name.name;
    expect(result, "First Last");
  }

  static void shouldReturnValidNameWhenValidLastName() {
    Name name = MockName(last: "Last").name;
    String result = name.name;
    expect(result, "First Last");
  }

  static void shouldReturnValidNameWhenValidFirstLastName() {
    Name name = MockName(first: "First", last: "Last").name;
    String result = name.name;
    expect(result, "First Last");
  }

  static void shouldReturnEmptyStringErrorWhenEmptyFirstName() {
    try {
      MockName(first: "");
    } catch (result) {
      expect(
          result.toString(),
          EmptyStringError(forObject: "String Attempt to capitalize")
              .toString());
      return;
    }
    Test.fallthrough;
  }

  static void shouldReturnEmptyStringErrorWhenEmptyLastName() {
    try {
      MockName(last: "");
    } catch (result) {
      expect(
          result.toString(),
          EmptyStringError(forObject: "String Attempt to capitalize")
              .toString());
      return;
    }
    Test.fallthrough;
  }
}

runNameTests() {
  group("Name", () {
    test("should return capitalized first name",
        NameTest.shouldReturnValidCapitalizedFirstNameWhenValidNameGiven);
    test("should return capitalized last name",
        NameTest.shouldReturnValidCapitalizedLastNameWhenValidNameGiven);
    test("should return first name",
        NameTest.shouldReturnValidFirstNameWhenValidNameGiven);
    test("should return last name",
        NameTest.shouldReturnValidLastNameWhenValidNameGiven);
    test("should return name from first name",
        NameTest.shouldReturnValidNameWhenValidFirstName);
    test("should return name from last name",
        NameTest.shouldReturnValidNameWhenValidLastName);
    test("should return name from first and last name",
        NameTest.shouldReturnValidNameWhenValidFirstLastName);
    test("should return empty string from empty first name",
        NameTest.shouldReturnEmptyStringErrorWhenEmptyFirstName);
    test("should return empty string from empty last name",
        NameTest.shouldReturnEmptyStringErrorWhenEmptyLastName);
  });
}
