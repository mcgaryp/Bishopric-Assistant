import 'package:bishop_assistant_web_test_app/util/Strings.dart';
import 'package:bishop_assistant_web_test_app/widgets/Section.dart';
import 'package:bishop_assistant_web_test_app/widgets/cards/assignment_cards/AssignmentCard.dart';
import 'package:bishop_assistant_web_test_app/widgets/cards/event_cards/EventCard.dart';
import 'package:bishop_assistant_web_test_app/widgets/cards/member_cards/MemberCard.dart';
import 'package:bishop_assistant_web_test_app/widgets/page_support/MobileConentSnapShot.dart';
import 'package:bishop_assistant_web_test_app/widgets/page_support/light_page/LightPage.dart';
import 'package:flutter/material.dart';

///
/// HomeMobile.dart
/// bishop_assistant_web_test_app
///
/// Created by porter on 8/13/21
/// Copyright 2021 porter. All rights reserved.
///

class HomeMobile extends StatelessWidget {
  final List<EventCard> eventsList;
  final List<AssignmentCard> assignmentsList;
  final List<MemberCard> membersList;

  const HomeMobile(this.eventsList, this.assignmentsList, this.membersList,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LightPage.mobile(MobileContentSnapShot([
      Section(events, eventsList),
      Section(assignments, assignmentsList),
      Section(organization, membersList)
    ]));
  }
}