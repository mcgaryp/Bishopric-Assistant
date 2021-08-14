import 'package:bishop_assistant_web_test_app/util/Strings.dart';
import 'package:bishop_assistant_web_test_app/widgets/Section.dart';
import 'package:bishop_assistant_web_test_app/widgets/page_support/LightPage.dart';
import 'package:bishop_assistant_web_test_app/widgets/page_support/MobileConentSnapShot.dart';
import 'package:flutter/material.dart';

///
/// HomeMobile.dart
/// bishop_assistant_web_test_app
///
/// Created by porter on 8/13/21
/// Copyright 2021 porter. All rights reserved.
///

class HomeMobile extends StatelessWidget {
  final List<Widget> eventsList;
  final List<Widget> assignmentsList;
  final List<Widget> membersList;
  const HomeMobile(this.eventsList, this.assignmentsList, this.membersList,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LightPage(children: [
      MobileContentSnapShot([
        // RowTitle(events),
        // Column(children: eventsList)
        Section(events, eventsList),
        Section(assignments, assignmentsList),
        Section(organization, membersList)
      ])
    ]);
  }
}
