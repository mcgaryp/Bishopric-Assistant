import 'package:bishop_assistant_web_test_app/theme/Colors.dart';
import 'package:bishop_assistant_web_test_app/theme/Fonts.dart';
import 'package:flutter/material.dart';

///
/// RowToggle.dart
/// bishop_assistant_web_test_app
///
/// Created by porter on 8/14/21
/// Copyright 2021 porter. All rights reserved.
///

class RowToggle extends StatefulWidget {
  final String label;
  const RowToggle(this.label, {Key? key}) : super(key: key);

  @override
  _RowToggleState createState() => _RowToggleState();
}

class _RowToggleState extends State<RowToggle> {
  bool isOn = true;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(widget.label, style: bodyStyle),
      Switch(
          activeColor: darkAccent,
          value: isOn,
          onChanged: (value) => setState(() => isOn = value))
    ]);
  }
}
