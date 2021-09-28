import 'package:models/models/user.dart';
import 'package:models/shared/entity.dart';
import 'package:models/util/extensions/string_extensions.dart';

///
/// user.dart
/// bishopric-assistant
///
/// Created by Po on 9/22/21
/// Copyright 2021 Po. All rights reserved.
///

/// [User] class creates the different types of users
/// TODO: I feel like this is wrong... Brother Manley how do I solve this one?
abstract class User extends Entity<User> {
  final UserID id;
  late final String _firstName;
  late final String _lastName;

  // factory User.generic(
  //     {required UserID id,
  //     required String firstName,
  //     required String lastName,
  //     required String username,
  //     required String password}) {
  //   return GenericUser(
  //       id: id,
  //       firstName: firstName,
  //       lastName: lastName,
  //       username: username,
  //       password: password);
  // }
  //
  // factory User.member(
  //     {required UserID id,
  //     required firstName,
  //     required lastName,
  //     required String email,
  //     required String phone,
  //     required Role role}) {
  //   return MemberUser(
  //       id: id,
  //       firstName: firstName,
  //       lastName: lastName,
  //       email: email,
  //       phone: phone,
  //       role: role);
  // }
  //
  // factory User.current(
  //     {required UserID id,
  //     required firstName,
  //     required lastName,
  //     required String username,
  //     required String password,
  //     required String email,
  //     required String phone,
  //     required Role role,
  //     required Privileges privileges}) {
  //   return CurrentUser(
  //       id: id,
  //       firstName: firstName,
  //       lastName: lastName,
  //       username: username,
  //       password: password,
  //       email: email,
  //       phone: phone,
  //       role: role,
  //       privileges: privileges);
  // }

  User({required this.id, required String firstName, required String lastName})
      : super(id) {
    this.__firstName = firstName;
    this.__lastName = lastName;
  }

  set __lastName(String name) => _lastName = name.capitalize;

  set __firstName(String name) => _firstName = name.capitalize;

  String get name => "$firstName $lastName";

  String get firstName => _firstName;

  String get lastName => _lastName;

  @override
  bool sameIdentityAs(User other) {
    return this.id == other.id;
  }
}
