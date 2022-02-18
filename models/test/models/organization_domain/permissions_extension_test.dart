import 'package:flutter_test/flutter_test.dart';
import 'package:models/models/organization.dart';
import 'package:models/shared/test.dart';

///
/// permissions_extension_test.dart
/// bishopric-assistant
///
/// Created by Po on 9/29/21
/// Copyright 2021 Po. All rights reserved.
///

class PermissionsExtensionTest implements Test {
  static void shouldReturnTrueWhenPermissionIsLessThanAnother() {
    bool result = Permissions.Maintainer < Permissions.Creator;
    expect(result, true);
    result = Permissions.Reporter < Permissions.Maintainer;
    expect(result, true);
    result = Permissions.Viewer < Permissions.Reporter;
    expect(result, true);
    result = Permissions.Viewer < Permissions.Creator;
    expect(result, true);
  }

  static void shouldReturnFalseWhenPermissionIsNotLessThanAnother() {
    bool result = Permissions.Creator < Permissions.Maintainer;
    expect(result, false);
    result = Permissions.Maintainer < Permissions.Reporter;
    expect(result, false);
    result = Permissions.Reporter < Permissions.Viewer;
    expect(result, false);
    result = Permissions.Creator < Permissions.Viewer;
    expect(result, false);
  }

  static void shouldReturnTrueWhenPermissionIsGreaterThanAnother() {
    bool result = Permissions.Creator > Permissions.Maintainer;
    expect(result, true);
    result = Permissions.Maintainer > Permissions.Reporter;
    expect(result, true);
    result = Permissions.Reporter > Permissions.Viewer;
    expect(result, true);
    result = Permissions.Creator > Permissions.Viewer;
    expect(result, true);
  }

  static void shouldReturnFalseWhenPermissionIsNotGreaterThanAnother() {
    bool result = Permissions.Maintainer > Permissions.Creator;
    expect(result, false);
    result = Permissions.Reporter > Permissions.Maintainer;
    expect(result, false);
    result = Permissions.Viewer > Permissions.Reporter;
    expect(result, false);
    result = Permissions.Viewer > Permissions.Creator;
    expect(result, false);
  }

  static void shouldReturnTrueWhenPermissionIsLessThanOrEqualToAnother() {
    bool result = Permissions.Creator <= Permissions.Creator;
    expect(result, true);
    result = Permissions.Maintainer <= Permissions.Creator;
    expect(result, true);
    result = Permissions.Maintainer <= Permissions.Maintainer;
    expect(result, true);
    result = Permissions.Reporter <= Permissions.Maintainer;
    expect(result, true);
    result = Permissions.Reporter <= Permissions.Reporter;
    expect(result, true);
    result = Permissions.Viewer <= Permissions.Reporter;
    expect(result, true);
    result = Permissions.Viewer <= Permissions.Viewer;
    expect(result, true);
    result = Permissions.Viewer <= Permissions.Creator;
    expect(result, true);
  }

  static void shouldReturnFalseWhenPermissionIsNotLessThanOrEqualToAnother() {
    bool result = Permissions.Creator <= Permissions.Maintainer;
    expect(result, false);
    result = Permissions.Maintainer <= Permissions.Reporter;
    expect(result, false);
    result = Permissions.Reporter <= Permissions.Viewer;
    expect(result, false);
    result = Permissions.Creator <= Permissions.Viewer;
    expect(result, false);
  }

  static void shouldReturnTrueWhenPermissionIsGreaterThanOrEqualToAnother() {
    bool result = Permissions.Creator >= Permissions.Creator;
    expect(result, true);
    result = Permissions.Creator >= Permissions.Maintainer;
    expect(result, true);
    result = Permissions.Maintainer >= Permissions.Maintainer;
    expect(result, true);
    result = Permissions.Maintainer >= Permissions.Reporter;
    expect(result, true);
    result = Permissions.Reporter >= Permissions.Reporter;
    expect(result, true);
    result = Permissions.Reporter >= Permissions.Viewer;
    expect(result, true);
    result = Permissions.Viewer >= Permissions.Viewer;
    expect(result, true);
    result = Permissions.Creator >= Permissions.Viewer;
    expect(result, true);
  }

  static void
      shouldReturnFalseWhenPermissionIsNotGreaterThanOrEqualToAnother() {
    bool result = Permissions.Maintainer >= Permissions.Creator;
    expect(result, false);
    result = Permissions.Reporter >= Permissions.Maintainer;
    expect(result, false);
    result = Permissions.Viewer >= Permissions.Reporter;
    expect(result, false);
    result = Permissions.Viewer >= Permissions.Creator;
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
