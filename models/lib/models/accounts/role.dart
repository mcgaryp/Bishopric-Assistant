import 'package:models/shared/exceptions.dart';
import 'package:models/shared/value_object.dart';

///
/// role.dart
/// bishopric-assistant
///
/// Created by Po on 9/28/21
/// Copyright 2021 Po. All rights reserved.
///

enum Character { creator, maintainer, reporter, viewer }

extension Characters on Character {
  String get string => this.toString();
}

class Role extends ValueObject<Role> {
  final Character character;
  late final String _anonymous;

  Role(this.character, {required String anonymous}) : super.decode({}) {
    __anonymous = anonymous;
  }

  set __anonymous(String anonymous) {
    if (anonymous.isEmpty) throw EmptyStringError();
    _anonymous = anonymous;
  }

  String get anonymous => _anonymous;

  @override
  bool sameValueAs(Role other) {
    return other.character == this.character &&
        other.anonymous == this.anonymous;
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != Role) return false;
    return sameValueAs(other as Role);
  }

  @override
  Map<String, dynamic> toJson() =>
      {"character": character.string, "anonymous": anonymous};
}
