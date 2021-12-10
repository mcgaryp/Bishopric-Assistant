import 'package:bishop_assistant_web_test_app/util/util.dart';
import 'package:bishop_assistant_web_test_app/widgets/widgets.dart';
import 'package:flutter/material.dart';

///
/// MemberDetails.dart
/// bishop_assistant_web_test_app
///
/// Created by Po on 8/17/21
/// Copyright 2021 Po. All rights reserved.
///

class MemberDetails extends StatelessWidget {
  const MemberDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LightPage(
        child: Section(title: sMemberDetails, children: [MemberDetailsCard()]));
  }
}
