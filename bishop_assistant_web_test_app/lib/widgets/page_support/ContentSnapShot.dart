import 'package:bishop_assistant_web_test_app/theme/Decorations.dart';
import 'package:bishop_assistant_web_test_app/theme/Fonts.dart';
import 'package:bishop_assistant_web_test_app/widgets/login_signup/MyDivider.dart';
import 'package:flutter/material.dart';

///
/// ContentSnapShot.dart
/// bishop_assistant_web_test_app
///
/// Created by porter on 8/13/21
/// Copyright 2021 porter. All rights reserved.
///

class ContentSnapShot extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const ContentSnapShot({required this.title, required this.children, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const EdgeInsets padding =
        EdgeInsets.only(top: padding8, left: padding8, right: padding8);

    return Expanded(
      child: Padding(
        padding: padding,
        child: Container(
          decoration: contentSnapShotDecoration,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: padding,
                child: Column(
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(title, style: subtitleStyle)),
                    MyDivider(),
                  ],
                ),
              ),
              Expanded(
                child: ListView(children: children),
              )
            ],
          ),
        ),
      ),
    );
  }
}
