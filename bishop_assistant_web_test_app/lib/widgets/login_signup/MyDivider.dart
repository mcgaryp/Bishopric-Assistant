import 'package:bishop_assistant_web_test_app/theme/Colors.dart';
import 'package:flutter/material.dart';

///
/// MyDivider.dart
/// bishop_assistant_web_test_app
///
/// Created by Porter McGary on 8/13/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

class MyDivider extends StatelessWidget {
  final Color color;

  const MyDivider({this.color = light, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(color: color, thickness: 2);
  }
}
