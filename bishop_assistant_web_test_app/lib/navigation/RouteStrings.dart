import 'package:bishop_assistant_web_test_app/MyFirebaseApp.dart';
import 'package:bishop_assistant_web_test_app/pages/ChangePassword.dart';
import 'package:bishop_assistant_web_test_app/pages/Home.dart';
import 'package:bishop_assistant_web_test_app/pages/Login.dart';
import 'package:bishop_assistant_web_test_app/pages/Pin.dart';
import 'package:bishop_assistant_web_test_app/pages/RequestPasswordReset.dart';
import 'package:bishop_assistant_web_test_app/pages/Signup.dart';
import 'package:flutter/cupertino.dart';

///
/// RouteStrings.dart
/// bishop_assistant_web_test_app
///
/// Created by Porter McGary on 8/13/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

const String rHome = "/home";
const String rLogin = "/login";
const String rSignup = "/signup";
const String rPasswordRequest = "/requestPassword";
const String rPIN = "/pin";
const String rChangePassword = "/changePassword";
const String rEvents = "/events";
const String rAssignments = "/assignments";
const String rOrganization = "/organization";
const String rProfile = "/profile";
const String rLegal = "/legal";
const String rPrivacy = "/privacy";

final Map<String, Widget Function(BuildContext)> routes = {
  "/": (context) => MyFirebaseApp(),
  rHome: (context) => Home(),
  rLogin: (context) => Login(),
  rSignup: (context) => Signup(),
  rPasswordRequest: (context) => RequestPasswordReset(),
  rPIN: (context) => Pin(),
  rChangePassword: (context) => ChangePassword(),
  // rEvents: (context) =>
  // rAssignments: (context) =>
  // rOrganization: (context) =>
  // rProfile: (context) =>
  // rLegal: (context) =>
  // rPrivacy: (context) =>
};
