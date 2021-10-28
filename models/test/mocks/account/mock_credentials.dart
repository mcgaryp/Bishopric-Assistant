import 'package:models/models/account.dart';

///
/// mock_credentials.dart
/// bishopric-assistant
///
/// Created by Po on 9/29/21
/// Copyright 2021 Po. All rights reserved.
///

class MockCredentials {
  static final String mockUsername = "mockUser";
  static final String mockPassword = "password";

  late final Credentials credentials;

  MockCredentials({String? username, String? password}) {
    credentials = Credentials(
        password: password ?? mockPassword, username: username ?? mockUsername);
  }
}
