import 'package:bishop_assistant_web_test_app/theme/theme.dart';
import 'package:bishop_assistant_web_test_app/util/util.dart';
import 'package:flutter/material.dart';
import 'package:models/models/organization.dart';

///
/// member_account_drawer_header.dart
/// bishop_assistant_web_test_app
///
/// Created by porter on 8/13/21
/// Copyright 2021 porter. All rights reserved.
///

class MyDrawerHeader extends StatelessWidget {
  final Member member;

  const MyDrawerHeader(this.member, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: 125),
      decoration: darkPrimaryBox,
      child: Padding(
        padding: const EdgeInsets.all(padding16),
        child: TextButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, rProfile);
          },
          style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              alignment: Alignment.centerLeft),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.only(bottom: padding8),
              child: Icon(
                Icons.person,
                color: light,
                size: 40,
              ),
            ),
            Text(member.name.fullName, style: bodyLight),
            Text(member.contact.email, style: captionDark)
          ]),
        ),
      ),
    );
  }
}
