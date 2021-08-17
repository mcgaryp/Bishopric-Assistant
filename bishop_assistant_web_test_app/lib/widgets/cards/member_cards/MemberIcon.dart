import 'package:bishop_assistant_web_test_app/theme/Colors.dart';
import 'package:bishop_assistant_web_test_app/theme/Decorations.dart';
import 'package:flutter/material.dart';

///
/// MemberIcon.dart
/// bishop_assistant_web_test_app
///
/// Created by Po on 8/16/21
/// Copyright 2021 Po. All rights reserved.
///

class MemberIcon extends StatelessWidget {
  final IconData icon;

  const MemberIcon(this.icon, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
      BoxDecoration(shape: BoxShape.circle, color: darkAccent),
      child: Padding(
        padding: const EdgeInsets.all(padding8),
        child: Icon(
          icon,
          color: white,
        ),
      ),
    );
  }
}