///
/// login_status.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 11/4/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

enum LoginStatus { loggedIn, loggedOut, unknown }

extension LoginStatusExtension on LoginStatus {
  String get string => this.toString().split('.').last;

  static LoginStatus fromString(String? string) {
    switch (string) {
      case "loggedIn":
        return LoginStatus.loggedIn;
      case "loggedOut":
        return LoginStatus.loggedOut;
      default:
        return LoginStatus.unknown;
    }
  }
}
