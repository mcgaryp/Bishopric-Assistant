import 'package:flutter/material.dart';

///
/// MyConstrainedBoxes.dart
/// bishop_assistant_web_test_app
///
/// Created by Porter McGary on 8/13/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

class MyConstrainedBox300 extends StatelessWidget {
  final List<Widget> children;
  const MyConstrainedBox300({required this.children, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 300),
      child: Column(children: children),
    );
  }
}

class MyConstrainedBox200 extends StatelessWidget {
  final List<Widget> children;
  const MyConstrainedBox200({required this.children, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 200),
      child: Column(children: children),
    );
  }
}
