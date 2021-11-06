import 'package:bishop_assistant_web_test_app/database/old_models_deprecated/Assignment.dart';
import 'package:bishop_assistant_web_test_app/util/strings.dart';
import 'package:bishop_assistant_web_test_app/widgets/cards/assignment_cards/CreateAssignment.dart';
import 'package:bishop_assistant_web_test_app/widgets/page_support/WebContentSnapShot.dart';
import 'package:bishop_assistant_web_test_app/widgets/page_support/light_page/light_page.dart';
import 'package:flutter/material.dart';

///
/// AssignmentWeb.dart
/// bishop_assistant_web_test_app
///
/// Created by Po on 8/15/21
/// Copyright 2021 Po. All rights reserved.
///

class AssignmentWeb extends StatelessWidget {
  const AssignmentWeb({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LightPage.web([
      WebContentSnapShot(
          title: assignments, children: Assignment.assignmentExampleCardList),
      WebContentSnapShot(
          title: createAssignment, children: [CreateAssignment()])
    ]);
  }
}
