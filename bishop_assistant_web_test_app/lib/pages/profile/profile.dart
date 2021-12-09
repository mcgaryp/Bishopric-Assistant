import 'package:bishop_assistant_web_test_app/theme/theme.dart';
import 'package:bishop_assistant_web_test_app/util/util.dart';
import 'package:bishop_assistant_web_test_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:models/models/organization.dart';

///
/// Profile.dart
/// bishop_assistant_web_test_app
///
/// Created by Po on 8/17/21
/// Copyright 2021 Po. All rights reserved.
///

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Member member = StateContainer.of(context).member;

    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          MyConstrainedBox300(children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [CardNavigationButton(sEdit, path: rEditProfile)],
            ),
          ]),
          MemberIcon(Icons.person, size: 65),
          Text(member.name.fullName, style: titleDark),
          Text(member.role.anonymous, style: subheadDark),
          MyConstrainedBox300(children: [
            MyDivider(color: dark),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: padding8),
              child: Column(children: [
                CardRow(sEmail, content: member.contact.email),
                CardRow(sPhone, content: member.contact.phone),
                CardRow(sAssignments, content: "1"),
                CardRow(sEvents, content: "3"),
              ]),
            )
          ]),
        ]);
  }
}
