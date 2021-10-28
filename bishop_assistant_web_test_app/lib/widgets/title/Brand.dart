import 'package:bishop_assistant_web_test_app/theme/Topography.dart';
import 'package:bishop_assistant_web_test_app/util/Strings.dart';
import 'package:bishop_assistant_web_test_app/widgets/AutoText.dart';
import 'package:flutter/material.dart';

///
/// Brand.dart
/// bishop_assistant_web_test_app
///
/// Created by Porter McGary on 8/13/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

class Brand extends StatelessWidget {
  final bool isExpanded;

  const Brand({this.isExpanded = true, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoText(brand, style: largeTitle, isExpanded: isExpanded);
  }
}
