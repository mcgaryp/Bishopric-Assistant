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
  final Member member;

  const MemberDetailsCard(this.member, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Permissions permissions =
        StateContainer.of(context).member.role.permissions;
    return MyCard(
      child: ExpansionTile(
          maintainState: true,
          title: MemberTitle(member),
          children: [
            if (permissions > Permissions.maintainer)
              Align(
                  alignment: Alignment.centerRight,
                  child: CardButton(label: sEdit, onPressed: () {})),
            MyDivider(color: darkPrimary),
            CardRow(sEmail, content: member.contact.email),
            CardRow(sPhone, content: member.contact.phone),
            CardRow(sCurrentAssignmentCount, content: "1"),
            CardRow(sCurrentEventCount, content: "2"),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                CardActionButton(label: sCreateEvent, onPressed: () {}),
                CardActionButton(label: sCreateAssignment, onPressed: () {}),
                if (permissions > Permissions.maintainer)
                  CardActionButton(
                      label: sRemove,
                      onPressed: () {},
                      style: MyButtonStyle.error)
              ],
            )
          ]),
    );

    return MyCard(children: [
      Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MemberTitle(member),
          CardButton(label: sEdit, onPressed: () {})
        ],
      ),
      MyDivider(color: darkPrimary),
      CardRow(sEmail, content: member.contact.email),
      CardRow(sPhone, content: member.contact.phone),
      // CardRow(sCurrentAssignmentCount, content: "1"),
      // CardRow(sCurrentEventCount, content: "2"),
      Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          CardActionButton(label: sCreateEvent, onPressed: () {}),
          CardActionButton(label: sCreateAssignment, onPressed: () {}),
          CardActionButton(
              label: sRemove, onPressed: () {}, style: MyButtonStyle.error)
        ],
      )
    ]);
  }
}
