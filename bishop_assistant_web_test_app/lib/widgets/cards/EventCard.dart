import 'package:bishop_assistant_web_test_app/database/Member.dart';
import 'package:bishop_assistant_web_test_app/theme/Decorations.dart';
import 'package:bishop_assistant_web_test_app/theme/Fonts.dart';
import 'package:bishop_assistant_web_test_app/util/Strings.dart';
import 'package:bishop_assistant_web_test_app/widgets/cards/CardSubtitle.dart';
import 'package:bishop_assistant_web_test_app/widgets/cards/CardTitle.dart';
import 'package:bishop_assistant_web_test_app/widgets/cards/MyCard.dart';
import 'package:flutter/material.dart';

///
/// EventCard.dart
/// bishop_assistant_web_test_app
///
/// Created by porter on 8/13/21
/// Copyright 2021 porter. All rights reserved.
///

// TODO: Object need recreated
class EventCard extends StatelessWidget {
  // TODO: Event Object in the future?
  final String title;
  final DateTime dateTime;
  final String? location;
  final List<Member>? mAssignees;
  final Member? mInterviewee;
  final String? mAgenda;
  final String? mNotes;

  const EventCard(
      {required this.title,
      required this.dateTime,
      this.location,
      this.mAssignees,
      this.mInterviewee,
      this.mAgenda,
      this.mNotes,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget? agendaStuff;
    Widget? noteStuff;
    List<Widget> assigneeList = [];

    if (mAgenda != null) {
      agendaStuff = Padding(
        padding: const EdgeInsets.only(bottom: padding8),
        child: Column(children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Text(agenda + ":", style: title2Style)),
          Align(
              alignment: Alignment.centerLeft,
              child: Text(mAgenda!, style: bodyStyle)),
        ]),
      );
    }

    if (mNotes != null) {
      noteStuff = Padding(
        padding: const EdgeInsets.only(bottom: padding8),
        child: Column(children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Text(notes + ":", style: title2Style)),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              mNotes!,
              style: bodyStyle,
              softWrap: true,
              overflow: TextOverflow.visible,
            ),
          )
        ]),
      );
    }

    if (mAssignees != null) {
      String amountOfAssignees = mAssignees!.length > 1 ? assignees : assignee;
      assigneeList.add(Align(
          alignment: Alignment.centerLeft,
          child: Text(amountOfAssignees + ":", style: title2Style)));
      for (Member assignee in mAssignees!) {
        assigneeList.add(Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "    ${assignee.firstName} ${assignee.lastName}",
            style: bodyStyle,
          ),
        ));
      }
    }

    return MyCard(children: [
      CardTitle(title),
      CardSubtitle(dateTime, location: location),
      if (agendaStuff != null) agendaStuff,
      if (noteStuff != null) noteStuff,
      if (mAssignees != null)
        Padding(
          padding: const EdgeInsets.only(bottom: padding8),
          child: Column(children: assigneeList),
        )
      // Text("Interviewee"),
      // Text("Name of Person"),
    ]);
  }
}
