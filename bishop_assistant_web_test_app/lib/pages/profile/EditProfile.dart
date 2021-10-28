import 'package:bishop_assistant_web_test_app/database/old_models_deprecated/Member.dart';
import 'package:bishop_assistant_web_test_app/theme/Colors.dart';
import 'package:bishop_assistant_web_test_app/theme/Decorations.dart';
import 'package:bishop_assistant_web_test_app/theme/Topography.dart';
import 'package:bishop_assistant_web_test_app/util/Strings.dart';
import 'package:bishop_assistant_web_test_app/widgets/InputField.dart';
import 'package:bishop_assistant_web_test_app/widgets/MyButton.dart';
import 'package:bishop_assistant_web_test_app/widgets/cards/member_cards/MemberIcon.dart';
import 'package:bishop_assistant_web_test_app/widgets/login_signup/MyConstrainedBoxes.dart';
import 'package:bishop_assistant_web_test_app/widgets/login_signup/MyDivider.dart';
import 'package:bishop_assistant_web_test_app/widgets/page_support/Mobile.dart';
import 'package:flutter/material.dart';

///
/// EditProfile.dart
/// bishop_assistant_web_test_app
///
/// Created by Po on 8/18/21
/// Copyright 2021 Po. All rights reserved.
///

class EditProfile extends Mobile {
  final Member member;

  const EditProfile(this.member, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          MemberIcon(member.image, size: 65),
          Text(member.name, style: titleDark),
          Text(member.role.string, style: subheadDark),
          MyConstrainedBox300(children: [
            MyDivider(color: dark),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: padding8),
              child: Column(
                children: [
                  InputField.border(member.email),
                  InputField.border(member.phone),
                  InputField.border(password, isPassword: true),
                  InputField.border(confirmPassword, isPassword: true),
                  MyButton(label: save, onPressed: () {})
                ],
              ),
            )
          ]),
        ]);
  }
}
