import 'package:bishop_assistant_web_test_app/navigation/WebNavigationButton.dart';
import 'package:bishop_assistant_web_test_app/navigation/route_strings.dart';
import 'package:bishop_assistant_web_test_app/theme/Colors.dart';
import 'package:bishop_assistant_web_test_app/util/Strings.dart';
import 'package:bishop_assistant_web_test_app/widgets/page_support/Error404.dart';
import 'package:bishop_assistant_web_test_app/widgets/title/Brand.dart';
import 'package:bishop_assistant_web_test_app/widgets/title/Logo.dart';
import 'package:flutter/material.dart';

import 'Content.dart';

///
/// Error404Page.dart
/// bishop_assistant_web_test_app
///
/// Created by Po on 8/15/21
/// Copyright 2021 Po. All rights reserved.
///

class Error404Page extends StatelessWidget {
  const Error404Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: light,
        appBar: AppBar(
          backgroundColor: darkPrimary,
          leading: Logo(),
          centerTitle: false,
          title: Brand(isExpanded: false),
          actions: [WebNavigationButton.label(home, path: rHome)],
        ),
        body: Content(
          child: Error404(),
        ));
  }
}
