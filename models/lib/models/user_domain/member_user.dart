import 'package:models/models/role.dart';
import 'package:models/models/user.dart';
import 'package:models/shared/exceptions.dart';

///
/// member_user.dart
/// bishopric-assistant
///
/// Created by porter on 9/27/21
/// Copyright 2021 porter. All rights reserved.
///

@Deprecated("Use Accounts")
class MemberUser extends User {
  late final String _email;
  late final String _phone;
  late final Role role;

  MemberUser(
      {required UserID id,
      required firstName,
      required lastName,
      required String email,
      required String phone,
      required this.role})
      : super(id: id, firstName: firstName, lastName: lastName) {
    __email = email;
    __phone = phone;
  }

  set __phone(String phone) {
    if (phone.isEmpty) throw EmptyStringError();
    _phone = phone;
  }

  set __email(String email) {
    if (email.isEmpty) throw EmptyStringError();
    _email = email;
  }

  String get email => _email;

  String get phone => _phone;
}
