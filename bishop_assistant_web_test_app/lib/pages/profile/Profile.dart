import 'package:bishop_assistant_web_test_app/database/old_models_deprecated/Member.dart';
import 'package:bishop_assistant_web_test_app/navigation/CardNavigationButton.dart';
import 'package:bishop_assistant_web_test_app/navigation/route_strings.dart';
import 'package:bishop_assistant_web_test_app/theme/Colors.dart';
import 'package:bishop_assistant_web_test_app/theme/Decorations.dart';
import 'package:bishop_assistant_web_test_app/theme/Topography.dart';
import 'package:bishop_assistant_web_test_app/util/strings.dart';
import 'package:bishop_assistant_web_test_app/widgets/cards/card_support/CardRow.dart';
import 'package:bishop_assistant_web_test_app/widgets/cards/member_cards/MemberIcon.dart';
import 'package:bishop_assistant_web_test_app/widgets/login_signup/MyConstrainedBoxes.dart';
import 'package:bishop_assistant_web_test_app/widgets/login_signup/MyDivider.dart';
import 'package:bishop_assistant_web_test_app/widgets/page_support/Mobile.dart';
import 'package:flutter/material.dart';

///
/// Profile.dart
/// bishop_assistant_web_test_app
///
/// Created by Po on 8/17/21
/// Copyright 2021 Po. All rights reserved.
///

class Profile extends Mobile {
  final OldMember member;

  const Profile(this.member, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          MyConstrainedBox300(children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [CardNavigationButton(edit, path: rEditProfile)],
            ),
          ]),
          MemberIcon(member.image, size: 65),
          Text(member.name, style: titleDark),
          Text(member.role.string, style: subheadDark),
          MyConstrainedBox300(children: [
            MyDivider(color: dark),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: padding8),
              child: Column(children: [
                CardRow(email, content: member.email),
                CardRow(phone, content: member.phone),
                CardRow(assignments, content: "1"),
                CardRow(events, content: "3"),
              ]),
            )
          ]),
        ]);
  }
}
