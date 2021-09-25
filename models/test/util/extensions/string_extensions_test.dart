import 'package:flutter_test/flutter_test.dart';
import 'package:models/util/extensions/string_extensions.dart';

///
/// string_extensions_test.dart
/// bishopric-assistant
///
/// Created by Po on 9/23/21
/// Copyright 2021 Po. All rights reserved.
///

class StringExtensionTest {
  static void shouldCapitalize() {
    // Arrange
    String lowerCase = "lowercase";
    // Act
    String result = lowerCase.capitalize;
    // Assert
    expect(result, "Lowercase");
  }

  static void isCapitalizedTrue() {
    // Arrange
    String capitalized = "Capitalized";
    // Act
    bool result = capitalized.isCapitalized;
    // Assert
    expect(result, true);
  }

  static void isCapitalizedFalse() {
    // Arrange
    String capitalized = "capitalized";
    // Act
    bool result = capitalized.isCapitalized;
    // Assert
    expect(result, false);
  }

  static void isNotCapitalizedTrue() {
    // Arrange
    String capitalized = "capitalized";
    // Act
    bool result = capitalized.isNotCapitalized;
    // Assert
    expect(result, true);
  }

  static void isNotCapitalizedFalse() {
    // Arrange
    String capitalized = "Capitalized";
    // Act
    bool result = capitalized.isNotCapitalized;
    // Assert
    expect(result, false);
  }

  static void checkCapitalization() {
    // Arrange
    String capitalized = "capitalized";
    // Act
    String result = capitalized.capitalize;
    // Assert
    expect(result, "Capitalized");
  }
}

main() {
  group("String Extension", () {
    test("should capitalize the first letter of the string",
        StringExtensionTest.shouldCapitalize);
    test("should return true", StringExtensionTest.isCapitalizedTrue);
    test("should return false", StringExtensionTest.isCapitalizedFalse);
    test("should return true", StringExtensionTest.isNotCapitalizedTrue);
    test("should return false", StringExtensionTest.isNotCapitalizedFalse);
    test("should capitalize the first letter of the string",
        StringExtensionTest.checkCapitalization);
  });
}
