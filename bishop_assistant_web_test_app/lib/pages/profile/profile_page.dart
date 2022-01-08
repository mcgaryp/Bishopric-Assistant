import 'package:bishop_assistant_web_test_app/pages/profile/display_profile.dart';
import 'package:bishop_assistant_web_test_app/pages/profile/edit_profile.dart';
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

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isEditing = false;

  @override
  Widget build(BuildContext context) {
    Account account = StateContainer.of(context).account;
    Member? member;
    bool isMember = StateContainer.of(context).isMember;
    if (isMember) member = StateContainer.of(context).member;

    return LightPage(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(children: [
              Spacer(),
              CardButton(label: sLogout, onPressed: _logout)
            ]),
            MemberIcon(Icons.person, size: 65),
            Text(account.name.fullName, style: titleDark),
            if (isMember) Text(member!.role.anonymous, style: subheadDark),
            MyConstrainedBox300(children: [
              MyDivider(color: dark),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: padding8),
                child: _isEditing ? EditProfile(_save) : DisplayProfile(_edit),
              ),
            ]),
          ]),
    );
  }

  void _edit() {
    _setIsEditing(true);
  }

  void _save() {
    _setIsEditing(false);
  }

  void _logout() {
    StateContainer.of(context)
        .logout(() => Navigator.pushReplacementNamed(context, rLogin));
  }

  void _setIsEditing(bool val) => setState(() => _isEditing = val);
}
