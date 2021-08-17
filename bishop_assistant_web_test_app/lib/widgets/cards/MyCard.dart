import 'package:bishop_assistant_web_test_app/theme/Decorations.dart';
import 'package:flutter/material.dart';

///
/// MyCard.dart
/// bishop_assistant_web_test_app
///
/// Created by porter on 8/13/21
/// Copyright 2021 porter. All rights reserved.
///

class MyCard extends StatelessWidget {
  final List<Widget> children;
  const MyCard({required this.children, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          bottom: padding8, left: padding8, right: padding8),
      child: Container(
        decoration: boxDecoration,
        child: Padding(
          padding: const EdgeInsets.all(padding16),
          child: Column(
            mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start, children: children),
        ),
      ),
    );
  }
}
