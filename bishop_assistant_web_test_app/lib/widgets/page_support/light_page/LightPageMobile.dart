import 'package:bishop_assistant_web_test_app/database/Member.dart';
import 'package:bishop_assistant_web_test_app/navigation/MobileNavigationButton.dart';
import 'package:bishop_assistant_web_test_app/navigation/RouteStrings.dart';
import 'package:bishop_assistant_web_test_app/theme/Colors.dart';
import 'package:bishop_assistant_web_test_app/theme/Decorations.dart';
import 'package:bishop_assistant_web_test_app/util/Strings.dart';
import 'package:bishop_assistant_web_test_app/widgets/MemberAccountDrawerHeader.dart';
import 'package:bishop_assistant_web_test_app/widgets/title/MyTitle.dart';
import 'package:flutter/material.dart';

import '../Content.dart';

///
/// LightPageMobile.dart
/// bishop_assistant_web_test_app
///
/// Created by porter on 8/13/21
/// Copyright 2021 porter. All rights reserved.
///

class LightPageMobile extends StatelessWidget {
  final List<Widget> children;
  final List<Widget> footer;
  const LightPageMobile(this.children, this.footer, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Action items
    final List<Widget> actions = [
      MemberDrawerHeader(Member()),
      MobileNavigationButton(home, rHome),
      MobileNavigationButton(events, rEvents),
      MobileNavigationButton(assignments, rAssignments),
      MobileNavigationButton(organization, rOrganization),
    ];

    return Scaffold(
      backgroundColor: white,
      drawer: Drawer(child: ListView(children: actions)),
      appBar: AppBar(
        backgroundColor: darkAccent,
        title: MyTitle(),
      ),
      body: Content(
        child: Padding(
          padding: const EdgeInsets.only(
              top: padding8, left: padding8, right: padding8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: children,
          ),
        ),
      ),
      persistentFooterButtons: footer,
    );
  }
}
