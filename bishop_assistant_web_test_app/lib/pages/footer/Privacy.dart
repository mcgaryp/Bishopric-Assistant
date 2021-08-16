import 'package:bishop_assistant_web_test_app/pages/ComingSoon.dart';
import 'package:bishop_assistant_web_test_app/widgets/page_support/light_page/LightPage.dart';
import 'package:flutter/material.dart';

///
/// Privacy.dart
/// bishop_assistant_web_test_app
///
/// Created by porter on 8/14/21
/// Copyright 2021 porter. All rights reserved.
///

class Privacy extends StatelessWidget {
  const Privacy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LightPage.both(ComingSoon());
  }
}
