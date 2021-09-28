import 'package:models/models/user.dart';

///
/// generic_user.dart
/// bishopric-assistant
///
/// Created by porter on 9/27/21
/// Copyright 2021 porter. All rights reserved.
///

class GenericUser extends User {
  late final String _username;
  late final String _password;

  GenericUser(
      {required UserID id,
      required firstName,
      required lastName,
      required String username,
      required String password})
      : super(id: id, firstName: firstName, lastName: lastName) {
    __username = username;
    __password = password;
  }

  set __username(String username) => _username = username;

  set __password(String password) => _password = password;

  String get password => _password;

  String get username => _username;
}
