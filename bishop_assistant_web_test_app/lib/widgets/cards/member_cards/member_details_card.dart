import 'package:bishop_assistant_web_test_app/theme/theme.dart';
import 'package:bishop_assistant_web_test_app/util/util.dart';
import 'package:bishop_assistant_web_test_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:models/models/organization.dart';

///
/// member_details_card.dart
/// bishop_assistant_web_test_app
///
/// Created by Po on 8/16/21
/// Copyright 2021 Po. All rights reserved.
///

class MemberDetailsCard extends StatelessWidget {
  const MemberDetailsCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Member member = StateContainer.of(context).member;

    return MyCard(children: [
      Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [MemberTitle(member), CardButton(sEdit, onPressed: () {})],
      ),
      MyDivider(color: darkPrimary),
      CardRow(sEmail, content: member.contact.email),
      CardRow(sPhone, content: member.contact.phone),
      CardRow(sCurrentAssignmentCount, content: "1"),
      CardRow(sCurrentEventCount, content: "2"),
      Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          CardActionButton(sCreateEvent, onPressed: () {}),
          CardActionButton(sCreateAssignment, onPressed: () {}),
          CardActionButton(sRemove,
              onPressed: () {}, style: MyButtonStyle.error)
        ],
      )
    ]);
  }
}
