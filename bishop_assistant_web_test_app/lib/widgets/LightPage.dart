import 'package:bishop_assistant_web_test_app/navigation/NavigationButton.dart';
import 'package:bishop_assistant_web_test_app/navigation/RouteStrings.dart';
import 'package:bishop_assistant_web_test_app/theme/Colors.dart';
import 'package:bishop_assistant_web_test_app/theme/Decorations.dart';
import 'package:bishop_assistant_web_test_app/theme/Fonts.dart';
import 'package:bishop_assistant_web_test_app/util/Strings.dart';
import 'package:bishop_assistant_web_test_app/widgets/Content.dart';
import 'package:flutter/material.dart';

///
/// LightPage.dart
/// bishop_assistant_web_test_app
///
/// Created by Porter McGary on 8/13/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

class LightPage extends StatelessWidget {
  final List<Widget> children;
  const LightPage({required this.children, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: Action items
    final List<Widget> actions = [
      NavigationButton(label: home, path: rHome),
      NavigationButton(label: events, path: rEvents),
      NavigationButton(label: assignments, path: rAssignments),
      NavigationButton(label: organization, path: rOrganization),
      NavigationButton(icon: Icons.person, path: rProfile),
    ];

    // TODO: Footer
    final List<Widget> footer = [
      Text("Legal"),
      Text("Privacy"),
      Text("SiteMap")
    ];

    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: darkAccent,
        leading: Center(child: Text("Logo Here")),
        leadingWidth: 75,
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: Text(brand, style: titleStyle),
        actions: actions,
      ),
      body: Content(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(padding8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: children,
            ),
          ),
        ),
      ),
      persistentFooterButtons: footer,
    );
  }
}
