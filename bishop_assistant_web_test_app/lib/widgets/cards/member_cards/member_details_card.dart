import 'package:bishop_assistant_web_test_app/widgets/widgets.dart';
import 'package:models/models/organization.dart';

///
/// member_details_card_.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 1/29/22
/// Copyright 2022 Porter McGary. All rights reserved.
///

class MemberDetailsCard extends StatelessWidget {
  final Member member;
  const MemberDetailsCard(this.member, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyCard(
      child: Column(children: [
        MemberTitle(member),
        MyDivider(color: darkPrimary),
        CardRow(sEmail, content: member.contact.email),
        CardRow(sPhone, content: member.contact.phone),
      ]),
    );
  }
}
