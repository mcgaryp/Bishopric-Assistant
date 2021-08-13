import 'package:bishop_assistant_web_test_app/navigation/RouteStrings.dart';
import 'package:bishop_assistant_web_test_app/util/Strings.dart';
import 'package:bishop_assistant_web_test_app/widgets/MyButton.dart';
import 'package:bishop_assistant_web_test_app/widgets/MySpacer.dart';
import 'package:bishop_assistant_web_test_app/widgets/Page.dart';
import 'package:bishop_assistant_web_test_app/widgets/login_signup/InputField.dart';
import 'package:bishop_assistant_web_test_app/widgets/login_signup/MyConstrainedBoxes.dart';
import 'package:bishop_assistant_web_test_app/widgets/login_signup/MyDivider.dart';
import 'package:bishop_assistant_web_test_app/widgets/title/Title.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyPage(children: [
      MyTitle(),
      MyDivider(),
      MyConstrainedBox300(
        children: [
          InputField(hint: username),
          InputField(hint: password),
          MySpacer(),
          MyConstrainedBox200(children: [
            MyButton(
                label: login,
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, rHome)),
            MyButton(
                label: signup,
                onPressed: () => Navigator.pushNamed(context, rSignup)),
            MyButton(
              label: forgot,
              onPressed: () {/* TODO Build Forget Page */},
              style: MyButtonStyle.text,
            )
          ])
        ],
      )
    ]);
  }
}
