import 'package:bishop_assistant_web_test_app/database/models/Member.dart';
import 'package:bishop_assistant_web_test_app/widgets/cards/CardTitle.dart';
import 'package:bishop_assistant_web_test_app/widgets/cards/MemberIcon.dart';
import 'package:bishop_assistant_web_test_app/widgets/cards/MyCard.dart';
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
        children: [
          MemberIcon(member.image),
          Column(
            children: [
              CardTitle(member.name),
              Row(
                children: [

                ],
              )
            ],
          ),
        ],
      )

    ]);
  }
}