import 'package:bishop_assistant_web_test_app/database/models/Member.dart';
import 'package:bishop_assistant_web_test_app/widgets/cards/MyCard.dart';
import 'package:bishop_assistant_web_test_app/widgets/cards/member_cards/MemberTitle.dart';
import 'package:flutter/material.dart';

///
/// MemberCard.dart
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
    return MyCard(children: [MemberTitle(member)]);
  }
}
