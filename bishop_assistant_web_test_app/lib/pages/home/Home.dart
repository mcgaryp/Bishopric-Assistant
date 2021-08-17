import 'package:bishop_assistant_web_test_app/database/models/Event.dart';
import 'package:bishop_assistant_web_test_app/database/models/Member.dart';
import 'package:bishop_assistant_web_test_app/pages/home/HomeMobile.dart';
import 'package:bishop_assistant_web_test_app/pages/home/HomeWeb.dart';
import 'package:bishop_assistant_web_test_app/widgets/cards/AssignmentCard.dart';
import 'package:bishop_assistant_web_test_app/widgets/cards/EventCard.dart';
import 'package:bishop_assistant_web_test_app/widgets/cards/member_cards/MemberCard.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

///
/// Home.dart
/// bishop_assistant_web_test_app
///
/// Created by Porter McGary on 8/13/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final List<Widget> eventsList = [
    EventCard(Meeting.example),
    EventCard(Interview.example),
  ];

  final List<Widget> assignmentsList = [
    AssignmentCard(
      title: "Set Appointment",
      dateTime: DateTime.now(),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: HomeMobile(eventsList, assignmentsList, Member.exampleMemberCardList),
      tablet: HomeWeb(eventsList, assignmentsList, Member.exampleMemberCardList),
    );
  }
}
