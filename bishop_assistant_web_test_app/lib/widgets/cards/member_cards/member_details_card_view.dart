import 'dart:async';

import 'package:the_assistant/widgets/cards/member_cards/edit_member_details_card.dart';
import 'package:the_assistant/widgets/widgets.dart';
import 'package:models/models/organization.dart';

///
/// member_details_card.dart
/// bishop_assistant_web_test_app
///
/// Created by Po on 8/16/21
/// Copyright 2021 Po. All rights reserved.
///

class MemberDetailsCardView extends StatelessWidget {
  final Stream<Member> memberStream;
  final bool _editable;

  const MemberDetailsCardView(this.memberStream, {Key? key})
      : _editable = false,
        super(key: key);

  const MemberDetailsCardView.editing(this.memberStream, {Key? key})
      : _editable = true,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: memberStream,
        builder: (BuildContext context, AsyncSnapshot<Member> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            Member member = snapshot.data!;
            return _editable
                ? EditMemberDetailsCard(member)
                : MemberDetailsCard(member);
          }
          if (snapshot.hasError)
            return Error404(msg: snapshot.error.toString());

          return SpinKitCircle(color: dark);
        });
  }
}
