import 'package:bishop_assistant_web_test_app/database/old_models_deprecated/Member.dart';
import 'package:bishop_assistant_web_test_app/navigation/FloatingNavigationButton.dart';
import 'package:bishop_assistant_web_test_app/navigation/MobileNavigationButton.dart';
import 'package:bishop_assistant_web_test_app/navigation/route_strings.dart';
import 'package:bishop_assistant_web_test_app/state/state_container.dart';
import 'package:bishop_assistant_web_test_app/theme/Colors.dart';
import 'package:bishop_assistant_web_test_app/theme/Decorations.dart';
import 'package:bishop_assistant_web_test_app/util/strings.dart';
import 'package:bishop_assistant_web_test_app/widgets/member_account_drawer_header.dart';
import 'package:bishop_assistant_web_test_app/widgets/page_support/Mobile.dart';
import 'package:bishop_assistant_web_test_app/widgets/title/MyTitle.dart';
import 'package:flutter/material.dart';

import '../Content.dart';

///
/// light_page_mobile.dart
/// bishop_assistant_web_test_app
///
/// Created by porter on 8/13/21
/// Copyright 2021 porter. All rights reserved.
///

class LightPageMobile extends StatelessWidget {
  final Mobile child;
  final List<Widget> footer;
  final bool hasButton;
  final String path;

  const LightPageMobile(this.child, this.footer,
      {this.path = "", this.hasButton = false, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final container = StateContainer.of(context);

    // Action items
    final List<Widget> actions = [
      MemberDrawerHeader(OldMember.bishopExample),
      MobileNavigationButton(home, rHome),
      if (container.hasOrganization) MobileNavigationButton(events, rEvents),
      if (container.hasOrganization)
        MobileNavigationButton(assignments, rAssignments),
      if (container.hasOrganization)
        MobileNavigationButton(organization, rOrganization),
    ];

    Widget body = hasButton
        ? Stack(children: [child, FloatingNavigationButton(path)])
        : child;

    return Scaffold(
      backgroundColor: lightGrey,
      drawer: Drawer(child: ListView(children: actions)),
      appBar: AppBar(
        backgroundColor: darkPrimary,
        title: MyTitle(),
      ),
      body: Content(
        child: Padding(
          padding: const EdgeInsets.only(
              top: padding8, left: padding8, right: padding8),
          child: body,
        ),
      ),
      persistentFooterButtons: footer,
    );
  }
}
