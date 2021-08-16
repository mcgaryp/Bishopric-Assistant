import 'package:bishop_assistant_web_test_app/database/models/Member.dart';
import 'package:bishop_assistant_web_test_app/util/Strings.dart';
import 'package:bishop_assistant_web_test_app/widgets/cards/MemberDetailsCard.dart';
import 'package:bishop_assistant_web_test_app/widgets/page_support/WebContentSnapShot.dart';
import 'package:bishop_assistant_web_test_app/widgets/page_support/light_page/LightPage.dart';
import 'package:flutter/material.dart';

///
/// OrganizationWeb.dart
/// bishop_assistant_web_test_app
///
/// Created by Po on 8/15/21
/// Copyright 2021 Po. All rights reserved.
///

class OrganizationWeb extends StatelessWidget {
  const OrganizationWeb({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LightPage.web([
      WebContentSnapShot(title: organization, children: Member.exampleMemberCardList),
      WebContentSnapShot(title: memberDetails, children: [MemberDetailsCard(Member.bishopExample)])
    ]);
  }
}