import 'package:bishop_assistant_web_test_app/widgets/Section.dart';
import 'package:bishop_assistant_web_test_app/widgets/page_support/Mobile.dart';
import 'package:bishop_assistant_web_test_app/widgets/page_support/SnapShotBackground.dart';
import 'package:flutter/material.dart';

///
/// MobileConentSnapShot.dart
/// bishop_assistant_web_test_app
///
/// Created by porter on 8/13/21
/// Copyright 2021 porter. All rights reserved.
///

class MobileContentSnapShot extends Mobile {
  final List<Section> children;

  const MobileContentSnapShot(this.children, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SnapShotBackground(child: ListView(children: children));
  }
}
