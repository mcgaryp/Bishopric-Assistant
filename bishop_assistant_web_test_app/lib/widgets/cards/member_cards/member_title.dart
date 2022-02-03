import 'package:bishop_assistant_web_test_app/widgets/widgets.dart';
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        MemberIcon(Icons.person),
        Padding(
          padding: const EdgeInsets.only(left: padding8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                member.name.fullName,
                style: subheadDark,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              Text(
                member.role.anonymous,
                style: footnoteDark,
              )
            ],
          ),
        )
      ],
    );
  }
}
