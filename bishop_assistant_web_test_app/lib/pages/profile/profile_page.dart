import 'package:bishop_assistant_web_test_app/theme/theme.dart';
import 'package:bishop_assistant_web_test_app/util/util.dart';
import 'package:bishop_assistant_web_test_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:models/models/account.dart';
import 'package:models/models/organization.dart';

///
/// Profile.dart
/// bishop_assistant_web_test_app
///
/// Created by Po on 8/17/21
/// Copyright 2021 Po. All rights reserved.
///

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Account account = StateContainer.of(context).account;

    return LightPage(
      child: Column(
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
            Text(account.name.fullName, style: titleDark),
            MyConstrainedBox300(children: [
              MyDivider(color: dark),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: padding8),
                child: Column(children: [
                  CardRow(sEmail, content: account.contact.email),
                  CardRow(sPhone, content: account.contact.phone),
                  CardRow(sAssignments, content: "1"),
                  CardRow(sEvents, content: "3"),
                ]),
              )
            ]),
          ]),
    );
  }
}
