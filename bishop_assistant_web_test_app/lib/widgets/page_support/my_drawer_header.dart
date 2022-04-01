import 'package:the_assistant/theme/theme.dart';
import 'package:the_assistant/util/util.dart';
import 'package:flutter/material.dart';
import 'package:models/models/account.dart';

///
/// member_account_drawer_header.dart
/// bishop_assistant_web_test_app
///
/// Created by porter on 8/13/21
/// Copyright 2021 porter. All rights reserved.
///

class MyDrawerHeader extends StatelessWidget {
  final Account account;

  const MyDrawerHeader(this.account, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
            Text(account.name.fullName, style: bodyLight),
            Text(account.contact.email, style: captionLight)
          ]),
        ),
      ),
    );
  }
}
