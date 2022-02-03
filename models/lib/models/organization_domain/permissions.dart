///
/// permissions.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 12/2/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

/// [Permissions] security levels to visualizing information
enum Permissions { Viewer, Reporter, Maintainer, Creator }

extension PermissionsExtension on Permissions {
  static Permissions fromString(String string) {
    if (string == Permissions.Creator.string) return Permissions.Creator;
    if (string == Permissions.Maintainer.string) return Permissions.Maintainer;
    if (string == Permissions.Reporter.string) return Permissions.Reporter;
    return Permissions.Viewer;
  }

  String get string {
    String str = this.toString().split('.').last;
    str = str[0].toUpperCase() + str.substring(1);
    return str;
  }

  operator <(Permissions rhs) {
    return this.index < rhs.index;
  }

  operator <=(Permissions rhs) {
    return this.index <= rhs.index;
  }

  operator >(Permissions rhs) {
    return this.index > rhs.index;
  }

  operator >=(Permissions rhs) {
    return this.index >= rhs.index;
  }
}
