import 'package:bishop_assistant_web_test_app/pages/footer/legal.dart';
import 'package:bishop_assistant_web_test_app/pages/footer/privacy.dart';
import 'package:bishop_assistant_web_test_app/pages/home/home.dart';
import 'package:bishop_assistant_web_test_app/pages/organization/organization_page.dart';
import 'package:bishop_assistant_web_test_app/pages/profile/profile_page.dart';
import 'package:bishop_assistant_web_test_app/pages/signup_login/login_page.dart';
import 'package:bishop_assistant_web_test_app/pages/signup_login/reactivate_account.dart';
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

// A B C D E F G H I J K L M N O P Q R S T U V W X Y Z
// Place in Alphabetical Order
// Place a `r` at the beginning of the variable to symbolize `route`
const String rAddAssignment = "/assignment/create";
const String rAddEvent = "/events/create";
const String rAssignments = "/assignments";
const String rChangePassword = "/changePassword";
const String rCreateOrganization = "/organization/create";
const String rEditProfile = "/profile/edit";
const String rEvents = "/events";
const String rHome = "/home";
const String rLegal = "/legal";
const String rLogin = "/login";
const String rMemberDetails = "/organization/member/details";
const String rOrganization = "/organization";
const String rPasswordRequest = "/requestPassword";
const String rPIN = "/pin";
const String rPrivacy = "/privacy";
const String rProfile = "/profile";
const String rReactivateAccount = "/reactivate";
const String rSignup = "/signup";

final Map<String, Widget Function(BuildContext)> routes = {
  "/": (context) => LoginPage(),
  rHome: (context) => Authenticate(child: HomePage()),
  rLogin: (context) => LoginPage(),
  rSignup: (context) => SignupPage(),
  // TODO: Uncomment
  // rPasswordRequest: (context) => RequestPasswordReset(),
  // rPIN: (context) => PinView(),
  // rChangePassword: (context) => ChangePassword(),
  rOrganization: (context) => Authenticate(child: OrganizationPage()),
  rProfile: (context) => Authenticate(child: ProfilePage()),
  rLegal: (context) => Legal(),
  rPrivacy: (context) => Privacy(),
  rReactivateAccount: (context) => ReactivateAccount(),
};
