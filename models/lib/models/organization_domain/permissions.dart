///
/// permissions.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 12/2/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

/// [Permissions] security levels to visualing information
enum Permissions { creator, maintainer, reporter, viewer }

extension PermissionsExtension on Permissions {
  String get string => this.toString();

  operator <(Permissions rhs) {
    return this.index > rhs.index;
  }

  operator <=(Permissions rhs) {
    return this.index >= rhs.index;
  }

  operator >(Permissions rhs) {
    return this.index < rhs.index;
  }

  operator >=(Permissions rhs) {
    return this.index <= rhs.index;
  }
}
