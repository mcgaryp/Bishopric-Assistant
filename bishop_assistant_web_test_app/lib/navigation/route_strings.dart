import 'package:bishop_assistant_web_test_app/my_firebase_app.dart';
import 'package:bishop_assistant_web_test_app/pages/assignment/AssignmentPage.dart';
import 'package:bishop_assistant_web_test_app/pages/assignment/CreateAssignmentMobile.dart';
import 'package:bishop_assistant_web_test_app/pages/event/CreateEventMobile.dart';
import 'package:bishop_assistant_web_test_app/pages/event/EventPage.dart';
import 'package:bishop_assistant_web_test_app/pages/footer/Legal.dart';
import 'package:bishop_assistant_web_test_app/pages/footer/Privacy.dart';
import 'package:bishop_assistant_web_test_app/pages/home/find_organization_page.dart';
import 'package:bishop_assistant_web_test_app/pages/home/home_page.dart';
import 'package:bishop_assistant_web_test_app/pages/organization/OrganizationPage.dart';
import 'package:bishop_assistant_web_test_app/pages/profile/EditProfilePage.dart';
import 'package:bishop_assistant_web_test_app/pages/profile/ProfilePage.dart';
import 'package:bishop_assistant_web_test_app/pages/recover_password/change_password.dart';
import 'package:bishop_assistant_web_test_app/pages/recover_password/pin_view.dart';
import 'package:bishop_assistant_web_test_app/pages/recover_password/request_password_reset.dart';
import 'package:bishop_assistant_web_test_app/pages/signup_login/login_page.dart';
import 'package:bishop_assistant_web_test_app/pages/signup_login/sign_up_page.dart';
import 'package:bishop_assistant_web_test_app/widgets/page_support/authentication/authenticate.dart';
import 'package:flutter/material.dart';

///
/// route_strings.dart
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
const String rAddAssignment = "/assignment/create";
const String rCreateOrganization = "/organization/create";
const String rMemberDetails = "/organization/member/details";
const String rEditProfile = "/profile/edit";

final Map<String, Widget Function(BuildContext)> routes = {
  "/": (context) => MyFirebaseApp(),
  rHome: (context) => Authenticate(child: HomePage()),
  rLogin: (context) => LoginPage(),
  rSignup: (context) => SignupPage(),
  // TODO: Add back when requestReset is implemented
  rPasswordRequest: (context) => RequestPasswordReset(),
  rPIN: (context) => PinView(),
  rChangePassword: (context) => ChangePassword(),
  rEvents: (context) => Authenticate(child: EventPage()),
  rAssignments: (context) => Authenticate(child: AssignmentPage()),
  rOrganization: (context) => Authenticate(child: OrganizationPage()),
  rCreateOrganization: (context) =>
      Authenticate(child: CreateOrganizationMobile()),
  rProfile: (context) => Authenticate(child: ProfilePage()),
  rLegal: (context) => Legal(),
  rPrivacy: (context) => Privacy(),
  rAddEvent: (context) => CreateEventMobile(),
  rAddAssignment: (context) => CreateAssignmentMobile(),
  // rMemberDetails: (context) => MemberDetails()
  rEditProfile: (context) => Authenticate(child: EditProfilePage()),
};
