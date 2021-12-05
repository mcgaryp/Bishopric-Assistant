import 'package:bishop_assistant_web_test_app/navigation/WebNavigationButton.dart';
import 'package:bishop_assistant_web_test_app/navigation/route_strings.dart';
import 'package:bishop_assistant_web_test_app/theme/Colors.dart';
import 'package:bishop_assistant_web_test_app/util/strings.dart';
import 'package:bishop_assistant_web_test_app/widgets/my_button.dart';
import 'package:bishop_assistant_web_test_app/widgets/page_support/error_404.dart';
import 'package:bishop_assistant_web_test_app/widgets/title/Brand.dart';
import 'package:bishop_assistant_web_test_app/widgets/title/Logo.dart';
import 'package:flutter/material.dart';

import 'Content.dart';

///
/// error_404_page.dart
/// bishop_assistant_web_test_app
///
/// Created by Po on 8/15/21
/// Copyright 2021 Po. All rights reserved.
///

class Error404Page extends StatelessWidget {
  final String? msg;
  const Error404Page({Key? key, this.msg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: light,
        appBar: AppBar(
          backgroundColor: darkPrimary,
          leading: Logo(),
          centerTitle: false,
          title: Brand(isExpanded: false),
          actions: [WebNavigationButton.label(sLogin, path: rLogin)],
        ),
        body: Content(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Error404(msg: msg),
              Container(
                width: 300,
                child: MyButton(
                    label: sLogin,
                    onPressed: () =>
                        Navigator.pushReplacementNamed(context, rLogin)),
              ),
            ],
          ),
        ));
  }
}
