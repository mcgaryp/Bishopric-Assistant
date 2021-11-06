import 'package:bishop_assistant_web_test_app/database/old_models_deprecated/Member.dart';
import 'package:bishop_assistant_web_test_app/theme/Decorations.dart';
import 'package:bishop_assistant_web_test_app/theme/Topography.dart';
import 'package:bishop_assistant_web_test_app/widgets/cards/member_cards/MemberIcon.dart';
import 'package:flutter/material.dart';

///
/// member_title.dart
/// bishop_assistant_web_test_app
///
/// Created by Po on 8/16/21
/// Copyright 2021 Po. All rights reserved.
///

class MemberTitle extends StatelessWidget {
  final OldMember member;

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
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                member.name,
                style: subheadDark,
              ),
              FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  member.role.string,
                  style: footnoteLight,
                  softWrap: true,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
