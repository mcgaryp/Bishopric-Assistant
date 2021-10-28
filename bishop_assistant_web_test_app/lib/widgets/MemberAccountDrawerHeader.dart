import 'package:bishop_assistant_web_test_app/database/old_models_deprecated/Member.dart';
import 'package:bishop_assistant_web_test_app/navigation/RouteStrings.dart';
import 'package:bishop_assistant_web_test_app/theme/Colors.dart';
import 'package:bishop_assistant_web_test_app/theme/Decorations.dart';
import 'package:bishop_assistant_web_test_app/theme/Topography.dart';
import 'package:flutter/material.dart';

///
/// MemberAccountDrawerHeader.dart
/// bishop_assistant_web_test_app
///
/// Created by porter on 8/13/21
/// Copyright 2021 porter. All rights reserved.
///

class MemberDrawerHeader extends StatelessWidget {
  final Member member;

  const MemberDrawerHeader(this.member, {Key? key}) : super(key: key);

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
                member.image,
                color: light,
                size: 40,
              ),
            ),
            Text("${member.firstName} ${member.lastName}", style: bodyLight),
            Text(member.email, style: captionDark)
          ]),
        ),
      ),
    );
  }
}
