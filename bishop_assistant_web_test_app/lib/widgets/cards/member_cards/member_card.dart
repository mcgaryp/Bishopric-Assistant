import 'package:bishop_assistant_web_test_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:models/models/organization.dart';

///
/// member_card.dart
/// bishop_assistant_web_test_app
///
/// Created by porter on 8/13/21
/// Copyright 2021 porter. All rights reserved.
///

class MemberCard extends StatelessWidget {
  final Member member;

  const MemberCard(this.member, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyCard(child: MemberTitle(member));
  }
}
