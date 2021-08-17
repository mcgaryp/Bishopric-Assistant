import 'package:bishop_assistant_web_test_app/theme/Decorations.dart';
import 'package:flutter/material.dart';

///
/// SnapShotBackground.dart
/// bishop_assistant_web_test_app
///
/// Created by porter on 8/13/21
/// Copyright 2021 porter. All rights reserved.
///

class SnapShotBackground extends StatelessWidget {
  final Widget child;

  const SnapShotBackground({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const EdgeInsets padding =
        EdgeInsets.only(top: padding8, left: padding8, right: padding8);

    return Padding(
      padding: padding,
      child: Container(
        decoration: floatingDarkPrimaryHalfBorderBox,
        child: Padding(padding: padding, child: child),
      ),
    );
  }
}
