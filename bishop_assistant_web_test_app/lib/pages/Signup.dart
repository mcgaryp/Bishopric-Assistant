import 'package:bishop_assistant_web_test_app/util/DatabasePaths.dart';
import 'package:bishop_assistant_web_test_app/util/Strings.dart';
import 'package:bishop_assistant_web_test_app/widgets/FirebaseDropDown.dart';
import 'package:bishop_assistant_web_test_app/widgets/MyButton.dart';
import 'package:bishop_assistant_web_test_app/widgets/MySpacer.dart';
import 'package:bishop_assistant_web_test_app/widgets/Page.dart';
import 'package:bishop_assistant_web_test_app/widgets/login_signup/InputField.dart';
import 'package:bishop_assistant_web_test_app/widgets/login_signup/MyConstrainedBoxes.dart';
import 'package:bishop_assistant_web_test_app/widgets/title/Title.dart';
import 'package:flutter/material.dart';

import '../widgets/login_signup/MyDivider.dart';

class Signup extends StatelessWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyPage(
      children: [
        MyTitle(),
        MyDivider(),
        MyConstrainedBox300(
          children: [
            InputField(hint: firstname),
            InputField(hint: lastname),
            InputField(hint: email),
            InputField(hint: phone),
            InputField(hint: password),
            InputField(hint: confirmPassword),
            FirebaseDropDown(
                collectionPath: Collections.roles,
                document: RolesDoc(),
                hint: role),
            InputField(hint: nameOfOrganization),
            MySpacer(),
            MyConstrainedBox200(children: [
              MyButton(label: signup, onPressed: () => Navigator.pop(context))
            ])
          ],
        ),
      ],
    );
  }
}
