import 'package:bishop_assistant_web_test_app/database/models/Event.dart';
import 'package:bishop_assistant_web_test_app/navigation/FloatingNavigationButton.dart';
import 'package:bishop_assistant_web_test_app/navigation/RouteStrings.dart';
import 'package:bishop_assistant_web_test_app/util/Strings.dart';
import 'package:bishop_assistant_web_test_app/widgets/Section.dart';
import 'package:bishop_assistant_web_test_app/widgets/cards/EventCard.dart';
import 'package:bishop_assistant_web_test_app/widgets/page_support/MobileConentSnapShot.dart';
import 'package:bishop_assistant_web_test_app/widgets/page_support/light_page/LightPage.dart';
import 'package:flutter/material.dart';

///
/// EventMobile.dart
/// bishop_assistant_web_test_app
///
/// Created by porter on 8/14/21
/// Copyright 2021 porter. All rights reserved.
///

class EventMobile extends StatelessWidget {
  const EventMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LightPage.mobileAction(MobileContentSnapShot([
        Section(events, [
          EventCard(Meeting.example),
          EventCard(Interview.example),
          EventCard(Meeting.example),
          EventCard(Interview.example),
        ])
      ]),
      rAddEvent
    );
  }
}
