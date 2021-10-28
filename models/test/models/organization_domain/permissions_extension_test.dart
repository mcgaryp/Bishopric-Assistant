import 'package:flutter_test/flutter_test.dart';
import 'package:models/models/organization.dart';

///
/// permissions_extension_test.dart
/// bishopric-assistant
///
/// Created by Po on 9/29/21
/// Copyright 2021 Po. All rights reserved.
///

class PermissionsExtensionTest {
  static void shouldReturnTrueWhenPermissionIsLessThanAnother() {
    bool result = Permissions.maintainer < Permissions.creator;
    expect(result, true);
    result = Permissions.reporter < Permissions.maintainer;
    expect(result, true);
    result = Permissions.viewer < Permissions.reporter;
    expect(result, true);
    result = Permissions.viewer < Permissions.creator;
    expect(result, true);
  }

  static void shouldReturnFalseWhenPermissionIsNotLessThanAnother() {
    bool result = Permissions.creator < Permissions.maintainer;
    expect(result, false);
    result = Permissions.maintainer < Permissions.reporter;
    expect(result, false);
    result = Permissions.reporter < Permissions.viewer;
    expect(result, false);
    result = Permissions.creator < Permissions.viewer;
    expect(result, false);
  }

  static void shouldReturnTrueWhenPermissionIsGreaterThanAnother() {
    bool result = Permissions.creator > Permissions.maintainer;
    expect(result, true);
    result = Permissions.maintainer > Permissions.reporter;
    expect(result, true);
    result = Permissions.reporter > Permissions.viewer;
    expect(result, true);
    result = Permissions.creator > Permissions.viewer;
    expect(result, true);
  }

  static void shouldReturnFalseWhenPermissionIsNotGreaterThanAnother() {
    bool result = Permissions.maintainer > Permissions.creator;
    expect(result, false);
    result = Permissions.reporter > Permissions.maintainer;
    expect(result, false);
    result = Permissions.viewer > Permissions.reporter;
    expect(result, false);
    result = Permissions.viewer > Permissions.creator;
    expect(result, false);
  }

  static void shouldReturnTrueWhenPermissionIsLessThanOrEqualToAnother() {
    bool result = Permissions.creator <= Permissions.creator;
    expect(result, true);
    result = Permissions.maintainer <= Permissions.creator;
    expect(result, true);
    result = Permissions.maintainer <= Permissions.maintainer;
    expect(result, true);
    result = Permissions.reporter <= Permissions.maintainer;
    expect(result, true);
    result = Permissions.reporter <= Permissions.reporter;
    expect(result, true);
    result = Permissions.viewer <= Permissions.reporter;
    expect(result, true);
    result = Permissions.viewer <= Permissions.viewer;
    expect(result, true);
    result = Permissions.viewer <= Permissions.creator;
    expect(result, true);
  }

  static void shouldReturnFalseWhenPermissionIsNotLessThanOrEqualToAnother() {
    bool result = Permissions.creator <= Permissions.maintainer;
    expect(result, false);
    result = Permissions.maintainer <= Permissions.reporter;
    expect(result, false);
    result = Permissions.reporter <= Permissions.viewer;
    expect(result, false);
    result = Permissions.creator <= Permissions.viewer;
    expect(result, false);
  }

  static void shouldReturnTrueWhenPermissionIsGreaterThanOrEqualToAnother() {
    bool result = Permissions.creator >= Permissions.creator;
    expect(result, true);
    result = Permissions.creator >= Permissions.maintainer;
    expect(result, true);
    result = Permissions.maintainer >= Permissions.maintainer;
    expect(result, true);
    result = Permissions.maintainer >= Permissions.reporter;
    expect(result, true);
    result = Permissions.reporter >= Permissions.reporter;
    expect(result, true);
    result = Permissions.reporter >= Permissions.viewer;
    expect(result, true);
    result = Permissions.viewer >= Permissions.viewer;
    expect(result, true);
    result = Permissions.creator >= Permissions.viewer;
    expect(result, true);
  }

  static void
      shouldReturnFalseWhenPermissionIsNotGreaterThanOrEqualToAnother() {
    bool result = Permissions.maintainer >= Permissions.creator;
    expect(result, false);
    result = Permissions.reporter >= Permissions.maintainer;
    expect(result, false);
    result = Permissions.viewer >= Permissions.reporter;
    expect(result, false);
    result = Permissions.viewer >= Permissions.creator;
    expect(result, false);
  }
}

runPermissionTests() {
  group("Permission Extension", () {
    test(
        "should return true any time a permission is less than another",
        PermissionsExtensionTest
            .shouldReturnTrueWhenPermissionIsLessThanAnother);
    test(
        "should return false any time a permission is not less than another",
        PermissionsExtensionTest
            .shouldReturnFalseWhenPermissionIsNotLessThanAnother);
    test(
        "should return true anytime a permission is greater than another",
        PermissionsExtensionTest
            .shouldReturnTrueWhenPermissionIsGreaterThanAnother);
    test(
        "should return false any time a permission is not greater than another",
        PermissionsExtensionTest
            .shouldReturnFalseWhenPermissionIsNotGreaterThanAnother);
    test(
        "should return true any time a permission is less than or equal to another",
        PermissionsExtensionTest
            .shouldReturnTrueWhenPermissionIsLessThanOrEqualToAnother);
    test(
        "should return false any time a permission is not less than or equal to another",
        PermissionsExtensionTest
            .shouldReturnFalseWhenPermissionIsNotLessThanOrEqualToAnother);
    test(
        "should return true any time a permission is greater than or equal to another",
        PermissionsExtensionTest
            .shouldReturnTrueWhenPermissionIsGreaterThanOrEqualToAnother);
    test(
        "should return false any time a permission is not greater than or equal to another",
        PermissionsExtensionTest
            .shouldReturnFalseWhenPermissionIsNotGreaterThanOrEqualToAnother);
  });
}
