import 'package:bishop_assistant_web_test_app/widgets/cards/CardSubtitle.dart';
import 'package:bishop_assistant_web_test_app/widgets/cards/CardTitle.dart';
import 'package:bishop_assistant_web_test_app/widgets/cards/MyCard.dart';
import 'package:flutter/material.dart';

///
/// AssignmentCard.dart
/// bishop_assistant_web_test_app
///
/// Created by porter on 8/13/21
/// Copyright 2021 porter. All rights reserved.
///

class AssignmentCard extends StatelessWidget {
  final String title;
  final DateTime dateTime;
  final String? mNotes;
  const AssignmentCard(
      {required this.title, required this.dateTime, this.mNotes, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyCard(children: [CardTitle(title), CardSubtitle(dateTime)]);
  }
}
