import 'package:bishop_assistant_web_test_app/database/Member.dart';
import 'package:bishop_assistant_web_test_app/pages/home/HomeMobile.dart';
import 'package:bishop_assistant_web_test_app/pages/home/HomeWeb.dart';
import 'package:bishop_assistant_web_test_app/widgets/cards/AssignmentCard.dart';
import 'package:bishop_assistant_web_test_app/widgets/cards/EventCard.dart';
import 'package:bishop_assistant_web_test_app/widgets/cards/MemberCard.dart';
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
  ];

  final List<Widget> assignmentsList = [
    AssignmentCard(
      title: "Set Appointment",
      dateTime: DateTime.now(),
    )
  ];

  final List<Widget> membersList = [
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
  ];

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: HomeMobile(eventsList, assignmentsList, membersList),
      desktop: HomeWeb(eventsList, assignmentsList, membersList),
      tablet: HomeMobile(eventsList, assignmentsList, membersList),
    );
  }
}
