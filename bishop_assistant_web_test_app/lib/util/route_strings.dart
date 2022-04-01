import 'package:the_assistant/main.dart';
import 'package:the_assistant/pages/assignment/assignment_page.dart';
import 'package:the_assistant/pages/footer/bug_report_page.dart';
import 'package:the_assistant/pages/footer/legal.dart';
import 'package:the_assistant/pages/footer/privacy.dart';
import 'package:the_assistant/pages/footer/site_map_page.dart';
import 'package:the_assistant/pages/home/home.dart';
import 'package:the_assistant/pages/organization/organization_page.dart';
import 'package:the_assistant/pages/profile/profile_page.dart';
import 'package:the_assistant/pages/signup_login/login_page.dart';
import 'package:the_assistant/pages/signup_login/reactivate_account.dart';
import 'package:the_assistant/pages/signup_login/sign_up_page.dart';
import 'package:the_assistant/pages/signup_login/signup_beta_page.dart';
import 'package:the_assistant/theme/theme_page.dart';
import 'package:the_assistant/widgets/page_support/authentication/authenticate.dart';
import 'package:flutter/foundation.dart';
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
const String rBugReport = "/bug-report";
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
const String rSignupBeta = "/signup-beta";
const String rSiteMap = "/sitemap";
const String rTheme = "/theme";

final Map<String, Widget Function(BuildContext)> routes = {
  rAssignments: (context) => Authenticate(child: AssignmentPage()),
  rHome: (context) => Authenticate(child: HomePage()),
  rLegal: (context) => Legal(),
  rLogin: (context) => LoginPage(),
  rOrganization: (context) => Authenticate(child: OrganizationPage()),
  rPrivacy: (context) => Privacy(),
  rProfile: (context) => Authenticate(child: ProfilePage()),
  rBugReport: (context) => Authenticate(child: BugReportPage()),
  rReactivateAccount: (context) => ReactivateAccount(),
  if (kDebugMode || isProd) rSignup: (context) => SignupPage(),
  if (kDebugMode || isBeta) rSignupBeta: (context) => SignupBetaPage(),
  rSiteMap: (context) => SiteMapPage(),
  if (kDebugMode) rTheme: (context) => ThemePage(),
};
