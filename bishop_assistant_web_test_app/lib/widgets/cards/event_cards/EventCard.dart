import 'package:bishop_assistant_web_test_app/database/old_models_deprecated/Event.dart';
import 'package:bishop_assistant_web_test_app/database/old_models_deprecated/Member.dart';
import 'package:bishop_assistant_web_test_app/theme/Topography.dart';
import 'package:bishop_assistant_web_test_app/util/strings.dart';
import 'package:bishop_assistant_web_test_app/widgets/cards/card_support/CardColumn.dart';
import 'package:bishop_assistant_web_test_app/widgets/cards/card_support/CardSubtitle.dart';
import 'package:bishop_assistant_web_test_app/widgets/cards/card_support/CardTitle.dart';
import 'package:bishop_assistant_web_test_app/widgets/cards/card_support/MyCard.dart';
import 'package:flutter/material.dart';

///
/// EventCard.dart
/// bishop_assistant_web_test_app
///
/// Created by porter on 8/13/21
/// Copyright 2021 porter. All rights reserved.
///

class EventCard extends StatelessWidget {
  final Event event;

  const EventCard(this.event, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget? agendaStuff;
    Widget? noteStuff;
    Widget? intervieweeStuff;
    Widget? assigneeStuff;

    if (event.agenda != null)
      agendaStuff = CardColumn(agenda, content: event.agenda!);

    if (event.notes != null)
      noteStuff = CardColumn(notes + ":", content: event.notes!);

    if (event.assignees != null) {
      List<Widget> assigneeList = [];
      String amountOfAssignees =
          event.assignees!.length > 1 ? assignees : assignee;
      for (OldMember assignee in event.assignees!) {
        assigneeList.add(Text(
          "    ${assignee.firstName} ${assignee.lastName}",
          style: bodyDark,
          textAlign: TextAlign.right,
        ));
      }
      assigneeStuff = Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(amountOfAssignees + ":", style: subheadDark),
          Expanded(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: assigneeList),
          )
        ],
      );
    }

    if (event.interviewee != null)
      intervieweeStuff =
          CardColumn(interviewee + ":", content: event.interviewee!);

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
