import 'dart:async';

import 'package:bishop_assistant_web_test_app/widgets/widgets.dart';
import 'package:models/models/organization.dart';

///
/// member_details_card.dart
/// bishop_assistant_web_test_app
///
/// Created by Po on 8/16/21
/// Copyright 2021 Po. All rights reserved.
///

class MemberDetailsCardView extends StatefulWidget {
  final Stream<Member> memberStream;

  const MemberDetailsCardView(this.memberStream, {Key? key}) : super(key: key);

  @override
  State<MemberDetailsCardView> createState() => _MemberDetailsCardViewState();
}

class _MemberDetailsCardViewState extends State<MemberDetailsCardView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: widget.memberStream,
        builder: (BuildContext context, AsyncSnapshot<Member> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            Member member = snapshot.data!;
            return MemberDetailsCard(member);
          }
          if (snapshot.hasError)
            return Error404(msg: snapshot.error.toString());

          return SpinKitCircle(color: dark);
        });
  }
}
