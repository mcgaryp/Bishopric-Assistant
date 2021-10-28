import 'package:bishop_assistant_web_test_app/database/old_models_deprecated/Assignment.dart';
import 'package:bishop_assistant_web_test_app/theme/Topography.dart';
import 'package:bishop_assistant_web_test_app/widgets/cards/card_support/CardSubtitle.dart';
import 'package:bishop_assistant_web_test_app/widgets/cards/card_support/CardTitle.dart';
import 'package:bishop_assistant_web_test_app/widgets/cards/card_support/MyCard.dart';
import 'package:flutter/material.dart';

///
/// AssignmentCard.dart
/// bishop_assistant_web_test_app
///
/// Created by porter on 8/13/21
/// Copyright 2021 porter. All rights reserved.
///

class AssignmentCard extends StatelessWidget {
  final Assignment assignment;

  const AssignmentCard(this.assignment, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyCard(children: [
      CardTitle(assignment.name),
      CardSubtitle(assignment.dateTime),
      if (assignment.notes != null) Text(assignment.notes!, style: bodyDark)
    ]);
  }
}
