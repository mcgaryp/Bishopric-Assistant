import 'package:bishop_assistant_web_test_app/theme/Colors.dart';
import 'package:bishop_assistant_web_test_app/theme/Decorations.dart';
import 'package:bishop_assistant_web_test_app/widgets/MySpacer.dart';
import 'package:bishop_assistant_web_test_app/widgets/login_signup/MyConstrainedBoxes.dart';
import 'package:bishop_assistant_web_test_app/widgets/login_signup/MyDivider.dart';
import 'package:bishop_assistant_web_test_app/widgets/page_support/Content.dart';
import 'package:bishop_assistant_web_test_app/widgets/title/Title.dart';
import 'package:flutter/material.dart';

///
/// DarkPage.dart
/// bishop_assistant_web_test_app
///
/// Created by Porter McGary on 8/13/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

class DarkPage extends StatelessWidget {
  final List<Widget> inputs;
  final List<Widget> buttons;

  const DarkPage({required this.inputs, required this.buttons, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: darkAccent,
        body: Content(
            child: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.all(padding8),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MyTitle(),
                          MyDivider(),
                          MyConstrainedBox300(
                            children: inputs,
                          ),
                          MySpacer(),
                          MyConstrainedBox200(children: buttons)
                        ])))));
  }
}
