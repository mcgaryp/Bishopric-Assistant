import 'package:models/models/account_domain/credentials.dart';
import 'package:models/shared/exceptions.dart';

///
/// smtp.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 12/3/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

class Smtp {
  final Credentials credentials;
  late final int _port;
  late final String _server;

  Smtp({required this.credentials, required int port, required String server}) {
    __port = port;
    __server = server;
  }

  Smtp.fromMap(Map<String, dynamic> map)
      : this(
            credentials: Credentials(
                password: map["password"], username: map["username"]),
            port: map["port"],
            server: map["server"]);

  set __port(int port) {
    if (port.isNegative) throw NegativeIntegerError(forObject: "Smtp");
    this._port = port;
  }

  set __server(String server) {
    if (server.isEmpty) throw EmptyStringError(forObject: "Smtp");
    _server = server;
  }

  String get server => _server;

  int get port => _port;
}
