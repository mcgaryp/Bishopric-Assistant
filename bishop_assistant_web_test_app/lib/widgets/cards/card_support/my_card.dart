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
  @deprecated
  final List<Widget>? children;
  final Widget? child;

  const MyCard({this.children, this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: padding8),
      child: Container(
        decoration: floatingLightBox,
        child: Padding(
          padding: const EdgeInsets.all(padding8),
          child: child ??
              Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: children ?? []),
        ),
      ),
    );
  }
}
