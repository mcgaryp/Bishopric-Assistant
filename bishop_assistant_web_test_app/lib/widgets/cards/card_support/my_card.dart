import 'package:bishop_assistant_web_test_app/theme/theme.dart';
import 'package:flutter/material.dart';

///
/// MyCard.dart
/// bishop_assistant_web_test_app
///
/// Created by porter on 8/13/21
/// Copyright 2021 porter. All rights reserved.
///

class MyCard extends StatelessWidget {
  final Widget child;
  final BoxDecoration decoration;

  const MyCard({required this.child, BoxDecoration? decoration, Key? key})
      : this.decoration = decoration ?? floatingLightBox,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: padding8),
      child: Container(
        decoration: decoration,
        child: Padding(
          padding: const EdgeInsets.all(padding8),
          child: child,
        ),
      ),
    );
  }
}
