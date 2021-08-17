import 'package:bishop_assistant_web_test_app/database/models/Member.dart';
import 'package:bishop_assistant_web_test_app/theme/Decorations.dart';
import 'package:bishop_assistant_web_test_app/theme/Fonts.dart';
import 'package:bishop_assistant_web_test_app/widgets/cards/member_cards/MemberIcon.dart';
import 'package:flutter/material.dart';

///
/// MemberTitle.dart
/// bishop_assistant_web_test_app
///
/// Created by Po on 8/16/21
/// Copyright 2021 Po. All rights reserved.
///

class MemberTitle extends StatelessWidget {
  final Member member;
  const MemberTitle(this.member, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        MemberIcon(member.image),
        Padding(
          padding: const EdgeInsets.only(left: padding8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                member.name,
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
    );
  }
}