import 'package:bishop_assistant_web_test_app/theme/theme.dart';
import 'package:bishop_assistant_web_test_app/util/util.dart';
import 'package:bishop_assistant_web_test_app/widgets/widgets.dart';
import 'package:flutter/material.dart';

///
/// light_page_mobile.dart
/// bishop_assistant_web_test_app
///
/// Created by porter on 8/13/21
/// Copyright 2021 porter. All rights reserved.
///

class LightPageMobile extends StatelessWidget {
  final Widget child;
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
      MyDrawerHeader(container.member),
      MobileNavigationButton(sHome, rHome),
      if (container.hasOrganization) MobileNavigationButton(sEvents, rEvents),
      if (container.hasOrganization)
        MobileNavigationButton(sAssignments, rAssignments),
      if (container.hasOrganization)
        MobileNavigationButton(sOrganization, rOrganization),
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
      body: Padding(
        padding: const EdgeInsets.only(
            top: padding8, left: padding8, right: padding8),
        child: body,
      ),
      persistentFooterButtons: footer,
    );
  }
}
