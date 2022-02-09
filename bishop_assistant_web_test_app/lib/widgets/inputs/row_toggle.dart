import 'package:bishop_assistant_web_test_app/theme/theme.dart';
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
  final void Function(bool)? onChanged;
  final bool value;
  final TextStyle _style;
  final Color _color;

  const RowToggle(this.label, {required this.value, this.onChanged, Key? key})
      : _style = body,
        _color = darkPrimary,
        super(key: key);

  const RowToggle.light(this.label,
      {required this.value, this.onChanged, Key? key})
      : _style = bodyLight,
        _color = light,
        super(key: key);

  @override
  _RowToggleState createState() => _RowToggleState();
}

class _RowToggleState extends State<RowToggle> {
  bool isOn = false;

  @override
  void initState() {
    isOn = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(widget.label, style: widget._style),
      Switch(
        activeColor: widget._color,
        value: isOn,
        onChanged: widget.onChanged,
      )
    ]);
  }
}
