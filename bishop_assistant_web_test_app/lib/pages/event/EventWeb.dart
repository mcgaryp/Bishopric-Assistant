import 'package:bishop_assistant_web_test_app/database/old_models_deprecated/Event.dart';
import 'package:bishop_assistant_web_test_app/util/Strings.dart';
import 'package:bishop_assistant_web_test_app/widgets/cards/event_cards/CreateEvent.dart';
import 'package:bishop_assistant_web_test_app/widgets/cards/event_cards/EventCard.dart';
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
    List<EventCard> example = [];
    example.addAll(Meeting.meetingExampleCardList);
    example.addAll(Interview.interviewExampleCardList);

    return LightPage.web([
      WebContentSnapShot(title: events, children: example),
      WebContentSnapShot(title: createEvent, children: [CreateEvent()])
    ]);
  }
}
