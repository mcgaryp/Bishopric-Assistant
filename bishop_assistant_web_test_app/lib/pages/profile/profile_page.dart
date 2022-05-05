import 'package:models/models/account.dart';
import 'package:models/models/organization.dart';
import 'package:the_assistant/pages/profile/display_profile.dart';
import 'package:the_assistant/pages/profile/edit_profile.dart';
import 'package:the_assistant/widgets/widgets.dart';

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
    Member? member;
    Account account = StateContainer.of(context).account;
    try {
      if (StateContainer.of(context).state >= UserState.inOrganization)
        member = StateContainer.of(context).member;
    } catch (e) {
      if (kDebugMode) print(e);
      return Error404Page(msg: e);
    }

    return LightPage(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(children: [
                Spacer(),
                MyButton(
                  label: sLogout,
                  onPressed: () async {
                    try {
                      await StateContainer.of(context).logout();
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        rLogin,
                        (Route route) => route.isCurrent,
                      );
                    } catch (e) {
                      MyToast.toastError(e);
                    }
                  },
                  style: MyButtonStyle.text,
                  isExpanded: false,
                ),
              ]),
            ),
            MemberIcon(Icons.person, size: 65),
            Text(
              account.name.fullName,
              style: title,
              textAlign: TextAlign.center,
            ),
            if (member != null) Text(member.role.name, style: subhead),
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

  void _setIsEditing(bool val) => setState(() => _isEditing = val);
}
