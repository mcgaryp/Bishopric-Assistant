import 'package:models/shared/foundation.dart';

///
/// credentials.dart
/// bishopric-assistant
///
/// Created by Po on 9/28/21
/// Copyright 2021 Po. All rights reserved.
///

/// [Credentials] contains the valuable information tied to logins and security
class Credentials extends ValueObject<Credentials> {
  /// [_password] holds the encrypted password to ensure safe usage and storage
  ///   of passwords
  late final String _password;

  /// [_username] holds the username string variable
  late final String _username;

  static const String _passwordKey = "password";
  static const String _usernameKey = "username";

  /// [Credentials(password: password, username: username)] ensures the correct
  ///   initialization of the [_password] and [_username]
  Credentials({required String password, required String username}) {
    __password = password;
    __username = username;
  }

  Credentials.fromMap(Map<String, dynamic> map)
      : this(password: map[_passwordKey], username: map[_usernameKey]);

  /// [__password] private setter to ensure the [_password] is hashed and not
  ///   empty
  /// TODO: Ensure password is hashed
  set __password(String password) {
    if (password.isEmpty)
      throw EmptyStringError(forObject: "Credentials Password");
    _password = password;
  }

  /// [__username] private setter to ensure the [_username] is not an empty
  ///   string
  set __username(String username) {
    if (username.isEmpty)
      throw EmptyStringError(forObject: "Credentials Username");
    _username = username;
  }

  /// [password] public getter to [_password]
  String get password => _password;

  /// [username] public getter to [_username]
  String get username => _username;

  @override
  bool sameValueAs(Credentials other) {
    return other.username == this.username && other.password == this.password;
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != Credentials) return false;
    return sameValueAs(other as Credentials);
  }

  @override
  String toString() {
    return username;
  }

  @override
  Map<String, dynamic> get toMap =>
      {_passwordKey: password, _usernameKey: username};
}
