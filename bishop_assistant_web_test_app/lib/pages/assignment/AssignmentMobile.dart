import 'package:bishop_assistant_web_test_app/database/old_models_deprecated/Assignment.dart';
import 'package:bishop_assistant_web_test_app/navigation/route_strings.dart';
import 'package:bishop_assistant_web_test_app/util/strings.dart';
import 'package:bishop_assistant_web_test_app/widgets/Section.dart';
import 'package:bishop_assistant_web_test_app/widgets/page_support/MobileConentSnapShot.dart';
import 'package:bishop_assistant_web_test_app/widgets/page_support/light_page/light_page.dart';
import 'package:flutter/material.dart';

///
/// AssignmentMobile.dart
/// bishop_assistant_web_test_app
///
/// Created by Po on 8/15/21
/// Copyright 2021 Po. All rights reserved.
///

class AssignmentMobile extends StatelessWidget {
  const AssignmentMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LightPage.mobileAction(
        MobileContentSnapShot(
            [Section(assignments, Assignment.assignmentExampleCardList)]),
        rAddAssignment);
  }
}
