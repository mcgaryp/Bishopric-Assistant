import 'package:bishop_assistant_web_test_app/database/models/Event.dart';
import 'package:bishop_assistant_web_test_app/util/Strings.dart';
import 'package:bishop_assistant_web_test_app/widgets/cards/CreateEvent.dart';
import 'package:bishop_assistant_web_test_app/widgets/cards/EventCard.dart';
import 'package:bishop_assistant_web_test_app/widgets/page_support/WebContentSnapShot.dart';
import 'package:bishop_assistant_web_test_app/widgets/page_support/light_page/LightPage.dart';
import 'package:flutter/material.dart';

///
/// EventWeb.dart
/// bishop_assistant_web_test_app
///
/// Created by porter on 8/14/21
/// Copyright 2021 porter. All rights reserved.
///

class EventWeb extends StatelessWidget {
  const EventWeb({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LightPage(children: [
      WebContentSnapShot(
          title: events,
          children: [EventCard(Meeting.example), EventCard(Interview.example)]),
      WebContentSnapShot(title: createEvent, children: [CreateEvent()])
    ]);
  }
}
