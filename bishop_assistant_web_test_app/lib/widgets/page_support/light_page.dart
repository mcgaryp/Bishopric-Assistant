import 'package:bishop_assistant_web_test_app/util/util.dart';
import 'package:bishop_assistant_web_test_app/widgets/page_support/app_bar/scaffold.dart';
import 'package:bishop_assistant_web_test_app/widgets/widgets.dart';
import 'package:flutter/material.dart';

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
    final container = StateContainer.of(context);

    // Action items
    final List<ActionModel> actions = [
      ActionModel(label: sHome, path: rHome),
      if (container.hasOrganization) ActionModel(label: sEvents, path: rEvents),
      if (container.hasOrganization)
        ActionModel(label: sAssignments, path: rAssignments),
      if (container.hasOrganization)
        ActionModel(
            label: sOrganization,
            path: rOrganization,
            notifications: container.organizationRequests),
      ActionModel(icon: Icons.person, path: rProfile),
    ];

    return SafeArea(
        bottom: false,
        top: false,
        child: MyScaffold.currentScaffold(context, actions, child));
  }
}