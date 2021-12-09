import 'package:bishop_assistant_web_test_app/theme/theme.dart';
import 'package:bishop_assistant_web_test_app/util/util.dart';
import 'package:bishop_assistant_web_test_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:models/shared/foundation.dart';

///
/// light_page.dart
/// bishop_assistant_web_test_app
///
/// Created by Porter McGary on 8/13/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

class LightPage extends StatelessWidget {
  final Widget child;
  final bool hasActionButton;
  final String? path;

  const LightPage(
      {required this.child, this.hasActionButton = false, this.path, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Footer
    final List<Widget> footer = [
      FooterButton(label: sLegal, path: rLegal),
      FooterButton(label: sPrivacy, path: rPrivacy),
      FooterButton(label: "SiteMap", path: rHome)
    ];

    final container = StateContainer.of(context);

    // Action items
    final List<Widget> actions = [
      WebNavigationButton.label(sHome, path: rHome),
      if (container.hasOrganization)
        WebNavigationButton.label(sEvents, path: rEvents),
      if (container.hasOrganization)
        WebNavigationButton.label(sAssignments, path: rAssignments),
      if (container.hasOrganization)
        WebNavigationButton.label(sOrganization,
            path: rOrganization, notifications: container.organizationRequests),
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
      body: Padding(
        padding: const EdgeInsets.only(
            top: padding8, left: padding8, right: padding8),
        child: Center(child: child),
      ),
      persistentFooterButtons: footer,
    );
  }
}
