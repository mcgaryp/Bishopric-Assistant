import 'package:bishop_assistant_web_test_app/MyFirebaseApp.dart';
import 'package:bishop_assistant_web_test_app/pages/assignment/AssignmentPage.dart';
import 'package:bishop_assistant_web_test_app/pages/organization/OrganizationPage.dart';
import 'package:bishop_assistant_web_test_app/pages/profile/ProfilePage.dart';
import 'package:bishop_assistant_web_test_app/pages/assignment/CreateAssignmentMobile.dart';
import 'package:bishop_assistant_web_test_app/pages/event/CreateEventMobile.dart';
import 'package:bishop_assistant_web_test_app/pages/event/EventPage.dart';
import 'package:bishop_assistant_web_test_app/pages/footer/Legal.dart';
import 'package:bishop_assistant_web_test_app/pages/footer/Privacy.dart';
import 'package:bishop_assistant_web_test_app/pages/home/Home.dart';
import 'package:bishop_assistant_web_test_app/pages/recover_password/ChangePassword.dart';
import 'package:bishop_assistant_web_test_app/pages/recover_password/Pin.dart';
import 'package:bishop_assistant_web_test_app/pages/recover_password/RequestPasswordReset.dart';
import 'package:bishop_assistant_web_test_app/pages/signup_login/Login.dart';
import 'package:bishop_assistant_web_test_app/pages/signup_login/Signup.dart';
import 'package:bishop_assistant_web_test_app/widgets/cards/CreateEvent.dart';
import 'package:flutter/material.dart';

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
const String rAddEvent = "/events/create";
const String rAddAssignment = "/organization/create";

final Map<String, Widget Function(BuildContext)> routes = {
  "/": (context) => MyFirebaseApp(),
  rHome: (context) => Home(),
  rLogin: (context) => Login(),
  rSignup: (context) => Signup(),
  rPasswordRequest: (context) => RequestPasswordReset(),
  rPIN: (context) => Pin(),
  rChangePassword: (context) => ChangePassword(),
  rEvents: (context) => EventPage(),
  rAssignments: (context) => AssignmentPage(),
  rOrganization: (context) => OrganizationPage(),
  rProfile: (context) => ProfilePage(),
  rLegal: (context) => Legal(),
  rPrivacy: (context) => Privacy(),
  rAddEvent: (context) => CreateEventMobile(),
  rAddAssignment: (context) => CreateAssignmentMobile(),
  // rMemberDetails: (context) =>
};
