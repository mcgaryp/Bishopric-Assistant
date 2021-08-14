import 'package:flutter/material.dart';

///
/// Content.dart
/// bishop_assistant_web_test_app
///
/// Created by Porter McGary on 8/13/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

class Content extends StatelessWidget {
  final Widget child;
  const Content({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: child);
  }
}
