import 'package:bishop_assistant_web_test_app/database/models/Member.dart';
import 'package:bishop_assistant_web_test_app/theme/Colors.dart';
import 'package:bishop_assistant_web_test_app/util/Strings.dart';
import 'package:bishop_assistant_web_test_app/widgets/MyButton.dart';
import 'package:bishop_assistant_web_test_app/widgets/cards/CardActionButton.dart';
import 'package:bishop_assistant_web_test_app/widgets/cards/CardButton.dart';
import 'package:bishop_assistant_web_test_app/widgets/cards/CardRow.dart';
import 'package:bishop_assistant_web_test_app/widgets/cards/MyCard.dart';
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
        children: [
          MemberTitle(member),
          CardButton(edit, onPressed: () {})
        ],
      ),
      MyDivider(color: darkAccent),
      CardRow(email, member.email),
      CardRow(phone, member.phone),
      CardRow(currentAssignmentCount, "1"),
      CardRow(currentEventCount, "2"),
      Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          CardActionButton(createAssignment, onPressed: () {}),
          CardActionButton(createAssignment, onPressed: () {}),
          CardActionButton(remove, onPressed: () {}, style: MyButtonStyle.error)
        ],
      )
    ]);
  }
}
