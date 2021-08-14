import 'package:bishop_assistant_web_test_app/database/models/Event.dart';
import 'package:bishop_assistant_web_test_app/database/models/Member.dart';
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
  final Event event;

  const EventCard(this.event, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget? agendaStuff;
    Widget? noteStuff;
    Widget? intervieweeStuff;
    Widget? assigneeStuff;

    if (event.agenda != null) {
      agendaStuff = Padding(
        padding: const EdgeInsets.only(bottom: padding8),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(agenda + ":", style: title2Style),
          Text(event.agenda!, style: bodyStyle),
        ]),
      );
    }

    if (event.notes != null) {
      noteStuff = Padding(
        padding: const EdgeInsets.only(bottom: padding8),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(notes + ":", style: title2Style),
          Text(
            event.notes!,
            style: bodyStyle,
            textAlign: TextAlign.justify,
          )
        ]),
      );
    }

    if (event.assignees != null) {
      List<Widget> assigneeList = [];
      String amountOfAssignees =
          event.assignees!.length > 1 ? assignees : assignee;
      for (Member assignee in event.assignees!) {
        assigneeList.add(Text(
          "    ${assignee.firstName} ${assignee.lastName}",
          style: bodyStyle,
        ));
      }
      assigneeStuff = Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(amountOfAssignees + ":", style: title2Style),
          Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              children: assigneeList)
        ],
      );
    }

    if (event.interviewee != null) {
      intervieweeStuff =
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(interviewee + ":", style: title2Style),
        Text(event.interviewee!, style: bodyStyle)
      ]);
    }

    return MyCard(children: [
      CardTitle(event.name),
      CardSubtitle(event.dateTime, location: event.location),
      if (agendaStuff != null) agendaStuff,
      if (noteStuff != null) noteStuff,
      if (assigneeStuff != null) assigneeStuff,
      if (intervieweeStuff != null) intervieweeStuff
    ]);
  }
}
