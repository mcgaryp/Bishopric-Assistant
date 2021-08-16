import 'package:bishop_assistant_web_test_app/pages/organization/OrganizationMobile.dart';
import 'package:bishop_assistant_web_test_app/pages/organization/OrganizationWeb.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

///
/// OrganizationPage.dart
/// bishop_assistant_web_test_app
///
/// Created by porter on 8/14/21
/// Copyright 2021 porter. All rights reserved.
///

class OrganizationPage extends StatelessWidget {
  const OrganizationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
        mobile: OrganizationMobile(), tablet: OrganizationWeb());
  }
}
