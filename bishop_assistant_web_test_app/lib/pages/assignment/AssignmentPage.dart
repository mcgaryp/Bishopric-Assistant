import 'package:bishop_assistant_web_test_app/pages/assignment/AssignmentMobile.dart';
import 'package:bishop_assistant_web_test_app/pages/assignment/AssignmentWeb.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

///
/// AssignmentPage.dart
/// bishop_assistant_web_test_app
///
/// Created by porter on 8/14/21
/// Copyright 2021 porter. All rights reserved.
///

class AssignmentPage extends StatelessWidget {
  const AssignmentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
        mobile: AssignmentMobile(), tablet: AssignmentWeb());
  }
}
