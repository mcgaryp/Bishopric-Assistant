import 'package:bishop_assistant_web_test_app/util/strings.dart';
import 'package:bishop_assistant_web_test_app/widgets/page_support/WebContentSnapShot.dart';
import 'package:bishop_assistant_web_test_app/widgets/page_support/light_page/light_page.dart';
import 'package:flutter/material.dart';

///
/// home_web.dart
/// bishop_assistant_web_test_app
///
/// Created by porter on 8/13/21
/// Copyright 2021 porter. All rights reserved.
///

class HomeWeb extends StatelessWidget {
  final List<Widget> eventsList;
  final List<Widget> assignmentsList;
  final List<Widget> membersList;

  const HomeWeb(this.eventsList, this.assignmentsList, this.membersList,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LightPage.web([
      WebContentSnapShot(title: events, children: eventsList),
      WebContentSnapShot(title: assignments, children: assignmentsList),
      WebContentSnapShot(
        title: organization,
        children: membersList,
      ),
    ]);
  }
}
