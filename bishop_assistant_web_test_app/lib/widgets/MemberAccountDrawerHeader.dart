import 'package:bishop_assistant_web_test_app/database/Member.dart';
import 'package:bishop_assistant_web_test_app/theme/Colors.dart';
import 'package:bishop_assistant_web_test_app/theme/Decorations.dart';
import 'package:bishop_assistant_web_test_app/theme/Fonts.dart';
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
      decoration: darkContentDecoration,
      child: Padding(
        padding: const EdgeInsets.all(padding16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.only(bottom: padding8),
            child: Icon(
              member.image,
              color: white,
              size: 40,
            ),
          ),
          Text("${member.firstName} ${member.lastName}", style: body2Style),
          Text(member.email, style: caption2Style)
        ]),
      ),
    );
  }
}
