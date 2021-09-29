import 'package:models/shared/exceptions.dart';
import 'package:models/shared/value_object.dart';

///
/// role.dart
/// bishopric-assistant
///
/// Created by Po on 9/28/21
/// Copyright 2021 Po. All rights reserved.
///

/// TODO: Comments
enum Permissions { creator, maintainer, reporter, viewer }

extension PermissionsExtension on Permissions {
  String get string => this.toString();

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

  operator +(Permissions rhs) {
    return this.index + 1;
  }

  operator -(Permissions rhs) {
    return this.index - 1;
  }
}

class Role extends ValueObject<Role> {
  final Permissions permissions;
  late final String _anonymous;

  Role(this.permissions, {required String anonymous}) : super.decode({}) {
    __anonymous = anonymous;
  }

  set __anonymous(String anonymous) {
    if (anonymous.isEmpty) throw EmptyStringError();
    _anonymous = anonymous;
  }

  String get anonymous => _anonymous;

  @override
  bool sameValueAs(Role other) {
    return other.permissions == this.permissions &&
        other.anonymous == this.anonymous;
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != Role) return false;
    return sameValueAs(other as Role);
  }

  @override
  Map<String, dynamic> toJson() =>
      {"character": permissions.string, "anonymous": anonymous};
}
