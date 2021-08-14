import 'package:bishop_assistant_web_test_app/database/models/Member.dart';
import 'package:bishop_assistant_web_test_app/theme/Colors.dart';
import 'package:bishop_assistant_web_test_app/theme/Decorations.dart';
import 'package:bishop_assistant_web_test_app/theme/Fonts.dart';
import 'package:bishop_assistant_web_test_app/widgets/cards/MyCard.dart';
import 'package:flutter/material.dart';

///
/// MemberCard.dart
/// bishop_assistant_web_test_app
///
/// Created by porter on 8/13/21
/// Copyright 2021 porter. All rights reserved.
///

class MemberCard extends StatelessWidget {
  final Member member;
  const MemberCard(this.member, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyCard(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: darkAccent),
            child: Padding(
              padding: const EdgeInsets.all(padding8),
              child: Icon(
                member.image,
                color: white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: padding8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${member.firstName} ${member.lastName}",
                  style: subtitle2Style,
                ),
                Text(
                  member.role.string,
                  style: captionStyle,
                )
              ],
            ),
          )
        ],
      )
    ]);
  }
}
