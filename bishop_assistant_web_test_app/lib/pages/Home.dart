import 'package:bishop_assistant_web_test_app/database/Member.dart';
import 'package:bishop_assistant_web_test_app/theme/Fonts.dart';
import 'package:bishop_assistant_web_test_app/util/Strings.dart';
import 'package:bishop_assistant_web_test_app/widgets/cards/AssignmentCard.dart';
import 'package:bishop_assistant_web_test_app/widgets/cards/EventCard.dart';
import 'package:bishop_assistant_web_test_app/widgets/cards/MemberCard.dart';
import 'package:bishop_assistant_web_test_app/widgets/page_support/ContentSnapShot.dart';
import 'package:bishop_assistant_web_test_app/widgets/page_support/LightPage.dart';
import 'package:flutter/material.dart';

///
/// Home.dart
/// bishop_assistant_web_test_app
///
/// Created by Porter McGary on 8/13/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget text = Text(
      "Ward Counsel",
      style: buttonStyle,
    );

    return LightPage(children: [
      ContentSnapShot(title: events, children: [
        EventCard(
          title: "Ward Counsel",
          dateTime: DateTime.now(),
          mAssignees: [Member(), Member()],
          mNotes:
              "It is a long established fact that a reader will be distracted by"
              " the readable content of a page when looking at its layout. "
              "The point of using Lorem Ipsum is that it has a more-or-less "
              "normal distribution of letters, as opposed to using 'Content "
              "here, content here', making it look like readable English. "
              "Many desktop publishing packages and web page editors now "
              "use Lorem Ipsum as their default model text, and a search "
              "for 'lorem ipsum' will uncover many web sites still in their "
              "infancy. Various versions have evolved over the years, "
              "sometimes by accident, sometimes on purpose (injected humour "
              "and the like).",
          mAgenda: " - paragraphs\n - words\n - bytes\n - lists",
          location: "Bishops office",
        ),
        EventCard(
          title: "Ward Counsel",
          dateTime: DateTime.now(),
        ),
      ]),
      ContentSnapShot(title: assignments, children: [
        AssignmentCard(
          title: "Set Appointment",
          dateTime: DateTime.now(),
        )
      ]),
      ContentSnapShot(title: organization, children: [
        MemberCard(Member()),
        MemberCard(Member()),
        MemberCard(Member()),
        MemberCard(Member()),
        MemberCard(Member()),
        MemberCard(Member()),
        MemberCard(Member()),
        MemberCard(Member()),
        MemberCard(Member()),
        MemberCard(Member()),
        MemberCard(Member()),
        MemberCard(Member()),
        MemberCard(Member()),
        MemberCard(Member()),
        MemberCard(Member()),
        MemberCard(Member()),
        MemberCard(Member()),
        MemberCard(Member()),
      ])
    ]);
  }
}
