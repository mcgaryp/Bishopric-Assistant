import 'package:bishop_assistant_web_test_app/pages/organization/organization_members_view.dart';
import 'package:bishop_assistant_web_test_app/pages/organization/organization_requests_view.dart';
import 'package:bishop_assistant_web_test_app/widgets/widgets.dart';
import 'package:flutter/material.dart';

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
    return LightPage(
        child: Column(
            children: [OrganizationRequestsView(), OrganizationMembersView()]));
  }
}
