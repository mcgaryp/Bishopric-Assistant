import 'package:bishop_assistant_web_test_app/theme/theme.dart';
import 'package:bishop_assistant_web_test_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';

///
/// Section.dart
/// bishop_assistant_web_test_app
///
/// Created by porter on 8/13/21
/// Copyright 2021 porter. All rights reserved.
///

class Section extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const Section(this.title, this.children, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StickyHeader(
        header: Container(color: darkPrimary, child: RowTitle(title)),
        content: Column(children: children));
  }
}
