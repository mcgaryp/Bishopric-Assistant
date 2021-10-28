import 'package:bishop_assistant_web_test_app/database/old_models_deprecated/Member.dart';
import 'package:bishop_assistant_web_test_app/util/Strings.dart';
import 'package:bishop_assistant_web_test_app/widgets/Section.dart';
import 'package:bishop_assistant_web_test_app/widgets/cards/member_cards/MemberDetailsCard.dart';
import 'package:bishop_assistant_web_test_app/widgets/page_support/MobileConentSnapShot.dart';
import 'package:bishop_assistant_web_test_app/widgets/page_support/light_page/LightPage.dart';
import 'package:flutter/material.dart';

///
/// MemberDetails.dart
/// bishop_assistant_web_test_app
///
/// Created by Po on 8/17/21
/// Copyright 2021 Po. All rights reserved.
///

class MemberDetails extends StatelessWidget {
  final Member member;

  const MemberDetails(this.member, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LightPage.mobile(MobileContentSnapShot([
      Section(memberDetails, [MemberDetailsCard(member)])
    ]));
  }
}
