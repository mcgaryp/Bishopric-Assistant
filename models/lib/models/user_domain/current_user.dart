import 'package:models/models/role.dart';
import 'package:models/models/user.dart';

///
/// current_user.dart
/// bishopric-assistant
///
/// Created by porter on 9/27/21
/// Copyright 2021 porter. All rights reserved.
///

class CurrentUser extends User {
  late final String _username;
  late final String _password;
  late final String _email;
  late final String _phone;
  late final Privileges privileges;
  late final Role role;

  CurrentUser(
      {required UserID id,
      required firstName,
      required lastName,
      required String username,
      required String password,
      required String email,
      required String phone,
      required Role role,
      required Privileges privileges})
      : super(id: id, firstName: firstName, lastName: lastName) {
    __email = email;
    __phone = phone;
    __password = password;
    __username = username;
    this.privileges = privileges;
    this.role = role;
  }

  set __phone(String phone) => _phone = phone;

  set __email(String email) => _email = email;

  set __username(String username) => _username = username;

  set __password(String password) => _password = password;

  String get password => _password;

  String get username => _username;

  String get email => _email;

  String get phone => _phone;
}
