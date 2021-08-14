import 'package:bishop_assistant_web_test_app/navigation/NavigationButton.dart';
import 'package:bishop_assistant_web_test_app/navigation/RouteStrings.dart';
import 'package:bishop_assistant_web_test_app/theme/Colors.dart';
import 'package:bishop_assistant_web_test_app/theme/Decorations.dart';
import 'package:bishop_assistant_web_test_app/util/Strings.dart';
import 'package:bishop_assistant_web_test_app/widgets/title/Brand.dart';
import 'package:bishop_assistant_web_test_app/widgets/title/Logo.dart';
import 'package:flutter/material.dart';

import 'Content.dart';

///
/// LightPageWeb.dart
/// bishop_assistant_web_test_app
///
/// Created by porter on 8/13/21
/// Copyright 2021 porter. All rights reserved.
///

class LightPageWeb extends StatelessWidget {
  final List<Widget> children;
  final List<Widget> footer;
  const LightPageWeb(this.children, this.footer, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Action items
    final List<Widget> actions = [
      NavigationButton(label: home, path: rHome),
      NavigationButton(label: events, path: rEvents),
      NavigationButton(label: assignments, path: rAssignments),
      NavigationButton(label: organization, path: rOrganization),
      NavigationButton(icon: Icons.person, path: rProfile),
    ];

    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: darkAccent,
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
