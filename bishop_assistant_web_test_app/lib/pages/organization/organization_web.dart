import 'package:bishop_assistant_web_test_app/database/old_models_deprecated/Member.dart';
import 'package:bishop_assistant_web_test_app/pages/organization/organization_members_view.dart';
import 'package:bishop_assistant_web_test_app/pages/organization/organization_requests_view.dart';
import 'package:bishop_assistant_web_test_app/util/strings.dart';
import 'package:bishop_assistant_web_test_app/util/util.dart';
import 'package:bishop_assistant_web_test_app/widgets/cards/member_cards/member_details_card.dart';
import 'package:bishop_assistant_web_test_app/widgets/page_support/WebContentSnapShot.dart';
import 'package:bishop_assistant_web_test_app/widgets/page_support/light_page/light_page.dart';
import 'package:bishop_assistant_web_test_app/widgets/page_support/page_support.dart';
import 'package:flutter/material.dart';
import 'package:models/models/account.dart';
import 'package:models/models/organization.dart';

///
/// OrganizationWeb.dart
/// bishop_assistant_web_test_app
///
/// Created by Po on 8/15/21
/// Copyright 2021 Po. All rights reserved.
///

class OrganizationWeb extends StatefulWidget {
  const OrganizationWeb({Key? key}) : super(key: key);

  @override
  _OrganizationWebState createState() => _OrganizationWebState();
}

class _OrganizationWebState extends State<OrganizationWeb> {
  OldMember selectedMember = OldMember.exampleMemberList[0];

  @override
  Widget build(BuildContext context) {
    return LightPage.web([
      WebContentSnapShot(
          title: organization,
          children: [OrganizationRequestsView(), OrganizationMembersView()]),
      WebContentSnapShot(
          title: memberDetails, children: [MemberDetailsCard(selectedMember)])
    ]);
  }

  void _selectNewMember(OldMember member) {
    setState(() {
      if (member != selectedMember) selectedMember = member;
    });
  }
}
