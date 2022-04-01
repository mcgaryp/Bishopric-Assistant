import 'package:bishop_assistant_web_test_app/widgets/widgets.dart';

///
/// error_404_page.dart
/// bishop_assistant_web_test_app
///
/// Created by Po on 8/15/21
/// Copyright 2021 Po. All rights reserved.
///

class Error404Page extends StatelessWidget {
  final Object? msg;
  final bool canLogin;

  const Error404Page({Key? key, this.msg, this.canLogin = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: light,
      appBar: AppBar(
        backgroundColor: darkPrimary,
        leading: Logo(),
        centerTitle: false,
        title: Brand(isExpanded: false),
        actions: [
          if (canLogin) WebNavigationButton.label(sLogin, path: rLogin)
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Error404(msg: msg),
            if (canLogin)
              Container(
                width: 300,
                child: MyButton(
                    label: sLogin,
                    onPressed: () =>
                        Navigator.pushReplacementNamed(context, rLogin)),
              ),
          ],
        ),
      ),
    );
  }
}
