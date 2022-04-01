import 'package:the_assistant/widgets/widgets.dart';
import 'package:models/models/organization.dart';

///
/// member_title.dart
/// bishop_assistant_web_test_app
///
/// Created by Po on 8/16/21
/// Copyright 2021 Po. All rights reserved.
///

class MemberTitle extends StatelessWidget {
  final Member member;

  const MemberTitle(this.member, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: MemberIcon(Icons.person),
      title: Text(
        member.name.fullName,
        style: subhead,
      ),
      subtitle: Text(
        member.role.name,
        style: captionDark,
      ),
    );
  }
}
