import 'package:bishop_assistant_web_test_app/database/old_models_deprecated/Member.dart';
import 'package:bishop_assistant_web_test_app/theme/Colors.dart';
import 'package:bishop_assistant_web_test_app/util/Strings.dart';
import 'package:bishop_assistant_web_test_app/widgets/MyButton.dart';
import 'package:bishop_assistant_web_test_app/widgets/cards/card_support/CardActionButton.dart';
import 'package:bishop_assistant_web_test_app/widgets/cards/card_support/CardButton.dart';
import 'package:bishop_assistant_web_test_app/widgets/cards/card_support/CardRow.dart';
import 'package:bishop_assistant_web_test_app/widgets/cards/card_support/MyCard.dart';
import 'package:bishop_assistant_web_test_app/widgets/cards/member_cards/MemberTitle.dart';
import 'package:bishop_assistant_web_test_app/widgets/login_signup/MyDivider.dart';
import 'package:flutter/material.dart';

///
/// MemberDetailsCard.dart
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
    return MyCard(children: [
      Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [MemberTitle(member), CardButton(edit, onPressed: () {})],
      ),
      MyDivider(color: darkPrimary),
      CardRow(email, content: member.email),
      CardRow(phone, content: member.phone),
      CardRow(currentAssignmentCount, content: "1"),
      CardRow(currentEventCount, content: "2"),
      Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          CardActionButton(createEvent, onPressed: () {}),
          CardActionButton(createAssignment, onPressed: () {}),
          CardActionButton(remove, onPressed: () {}, style: MyButtonStyle.error)
        ],
      )
    ]);
  }
}