import 'package:bishop_assistant_web_test_app/pages/ComingSoon.dart';
import 'package:bishop_assistant_web_test_app/widgets/page_support/Mobile.dart';
import 'package:bishop_assistant_web_test_app/widgets/page_support/Web.dart';
import 'package:bishop_assistant_web_test_app/widgets/page_support/light_page/LightPage.dart';
import 'package:flutter/material.dart';

///
/// ProfilePage.dart
/// bishop_assistant_web_test_app
///
/// Created by porter on 8/14/21
/// Copyright 2021 porter. All rights reserved.
///

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LightPage.both(
      ComingSoon()
    );
  }
}

