import 'package:bishop_assistant_web_test_app/pages/event/EventMobile.dart';
import 'package:bishop_assistant_web_test_app/pages/event/EventWeb.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

///
/// EventPage.dart
/// bishop_assistant_web_test_app
///
/// Created by porter on 8/14/21
/// Copyright 2021 porter. All rights reserved.
///

class EventPage extends StatelessWidget {
  const EventPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
        mobile: EventMobile(), desktop: EventWeb(), tablet: EventWeb());
  }
}
