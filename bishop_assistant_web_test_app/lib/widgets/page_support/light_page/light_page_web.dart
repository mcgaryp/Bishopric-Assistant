import 'package:bishop_assistant_web_test_app/navigation/WebNavigationButton.dart';
import 'package:bishop_assistant_web_test_app/navigation/route_strings.dart';
import 'package:bishop_assistant_web_test_app/state/state_container.dart';
import 'package:bishop_assistant_web_test_app/theme/Colors.dart';
import 'package:bishop_assistant_web_test_app/theme/Decorations.dart';
import 'package:bishop_assistant_web_test_app/util/strings.dart';
import 'package:bishop_assistant_web_test_app/widgets/page_support/Web.dart';
import 'package:bishop_assistant_web_test_app/widgets/page_support/page_support.dart';
import 'package:bishop_assistant_web_test_app/widgets/title/Brand.dart';
import 'package:bishop_assistant_web_test_app/widgets/title/Logo.dart';
import 'package:flutter/material.dart';

///
/// light_page_web.dart
/// bishop_assistant_web_test_app
///
/// Created by porter on 8/13/21
/// Copyright 2021 porter. All rights reserved.
///

class LightPageWeb extends StatelessWidget {
  final List<Web> children;
  final List<Widget> footer;

  const LightPageWeb(this.children, this.footer, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final container = StateContainer.of(context);

    // Action items
    final List<Widget> actions = [
      WebNavigationButton.label(home, path: rHome),
      if (container.hasOrganization)
        WebNavigationButton.label(events, path: rEvents),
      if (container.hasOrganization)
        WebNavigationButton.label(assignments, path: rAssignments),
      if (container.hasOrganization)
        WebNavigationButton.label(organization,
            path: rOrganization, notifications: container.organizationRequests),
      if (container.hasOrganization)
        WebNavigationButton.icon(Icons.person, path: rProfile),
    ];

    return Scaffold(
      backgroundColor: lightGrey,
      appBar: AppBar(
        backgroundColor: darkPrimary,
        leading: Logo(),
        centerTitle: false,
        title: Brand(isExpanded: false),
        actions: actions,
      ),
      body: Content(
        child: Padding(
          padding: const EdgeInsets.only(
              top: padding8, left: padding8, right: padding8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: children,
          ),
        ),
      ),
      persistentFooterButtons: footer,
    );
  }
}
