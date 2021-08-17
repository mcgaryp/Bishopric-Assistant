import 'package:bishop_assistant_web_test_app/database/models/Assignment.dart';
import 'package:bishop_assistant_web_test_app/database/models/Event.dart';
import 'package:bishop_assistant_web_test_app/database/models/Member.dart';
import 'package:bishop_assistant_web_test_app/pages/home/HomeMobile.dart';
import 'package:bishop_assistant_web_test_app/pages/home/HomeWeb.dart';
import 'package:bishop_assistant_web_test_app/widgets/cards/event_cards/EventCard.dart';
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

  final List<EventCard> eventsList = [
    EventCard(Meeting.example1),
    EventCard(Meeting.example2),
    EventCard(Interview.example1),
    EventCard(Meeting.example3),
    EventCard(Interview.example2)
  ];

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: HomeMobile(eventsList, Assignment.assignmentExampleCardList,
          Member.exampleMemberCardList),
      tablet: HomeWeb(eventsList, Assignment.assignmentExampleCardList,
          Member.exampleMemberCardList),
    );
  }
}
