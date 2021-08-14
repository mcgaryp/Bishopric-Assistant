import 'package:bishop_assistant_web_test_app/widgets/RowTitle.dart';
import 'package:bishop_assistant_web_test_app/widgets/page_support/SnapShotBackground.dart';
import 'package:flutter/material.dart';

///
/// WebContentSnapShot.dart
/// bishop_assistant_web_test_app
///
/// Created by porter on 8/13/21
/// Copyright 2021 porter. All rights reserved.
///

class WebContentSnapShot extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const WebContentSnapShot(
      {required this.title, required this.children, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SnapShotBackground(
      child: Column(
        children: [
          RowTitle(title),
          Expanded(child: ListView(children: children))
        ],
      ),
      // Expanded(child: ListView(children: children))
    );
  }
}
