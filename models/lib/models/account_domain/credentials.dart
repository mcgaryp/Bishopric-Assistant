import 'package:models/shared/foundation.dart';

///
/// credentials.dart
/// bishopric-assistant
///
/// Created by Po on 9/28/21
/// Copyright 2021 Po. All rights reserved.
///

class Credentials extends ValueObject<Credentials> {
  late final String _password;
  late final String _username;

  Credentials({required String password, required String username})
      : super.decode({"password": password, "username": username}) {
    __password = password;
    __username = username;
  }

  set __password(String password) {
    if (password.isEmpty) throw EmptyStringError();
    _password = password;
  }

  set __username(String username) {
    if (username.isEmpty) throw EmptyStringError();
    _username = username;
  }

  String get password => _password;

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
  Map<String, dynamic> toJson() => {"password": password, "username": username};
}
