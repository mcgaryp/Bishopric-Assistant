import 'package:models/util/extensions/string_extensions.dart';

///
/// user.dart
/// bishopric-assistant
///
/// Created by Po on 9/22/21
/// Copyright 2021 Po. All rights reserved.
///

/// [User] class includes the name, first, and last names of the user
/// TODO: Define the factory users for Organization & Member
/// TODO: Comments
class User {
  late final String _firstName;
  late final String _lastName;
  late final String _password;
  late final String _username;
  late final String _phone;
  late final String _email;

  User({required String firstName, required String lastName}) {
    this.__firstName = firstName;
    this.__lastName = lastName;
  }

  set __lastName(String name) => _lastName = name.capitalize;
  set __firstName(String name) => _firstName = name.capitalize;

  String get name => "$firstName $lastName";
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get email => _email;
}
