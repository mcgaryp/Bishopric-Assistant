import 'package:models/models/account.dart';
import 'package:models/models/account_domain/credentials.dart';

///
/// $FILE_NAME.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 3/16/22
/// Copyright 2022 Porter McGary. All rights reserved.
///

class DBCredentials {
  static const String idKey = "Credentials ID";
  static const String usernameKey = "Credentials username";
  static const String passwordKey = "Credentials password";

  String? username;
  String? password;
  String? id;

  DBCredentials({this.id, this.username, this.password});

  DBCredentials.fromMap(Map<String, dynamic> map)
      : this(
          id: map[idKey],
          username: map[usernameKey],
          password: map[passwordKey],
        );

  DBCredentials.fromCredentials(Credentials credentials)
      : this(username: credentials.username, password: credentials.password);

  Credentials get toCredentials {
    if (password == null || username == null)
      throw Exception("Unable to convert to Credentials");
    return Credentials(password: password!, username: username!);
  }

  Map<String, dynamic> get toMap => {
        idKey: id,
        passwordKey: password,
        usernameKey: username,
      };
}
