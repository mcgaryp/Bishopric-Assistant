import 'package:bishop_assistant_web_test_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

///
/// CardRow.dart
/// bishop_assistant_web_test_app
///
/// Created by Po on 8/16/21
/// Copyright 2021 Po. All rights reserved.
///

class CardRow extends StatelessWidget {
  final String label;
  final String content;

  const CardRow(this.label, {required this.content, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: padding8),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: bodyDark),
          Text(content, style: bodyDark)
        ],
      ),
    );
  }
}
