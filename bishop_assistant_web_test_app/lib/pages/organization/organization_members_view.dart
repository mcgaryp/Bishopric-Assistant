import 'package:bishop_assistant_web_test_app/repositories/firebase_member_repository.dart';
import 'package:bishop_assistant_web_test_app/theme/theme.dart';
import 'package:bishop_assistant_web_test_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:models/models/organization.dart';

///
/// organization_members_view.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 12/9/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

class OrganizationMembersView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DefaultAllOrganizationMembersUseCase useCase =
        DefaultAllOrganizationMembersUseCase(FirebaseMemberRepository());
    Organization organization = StateContainer.of(context).organization;

    return StreamBuilder<List<Stream<Member>>>(
      stream: useCase.execute(organization.id),
      builder: (BuildContext context, AsyncSnapshot<List<Stream<Member>>> snapshot) {
        if (snapshot.hasData) {
          List<Stream<Member>>? members = snapshot.data;
          if (members == null) return Container();
          return Column(
              children: members
                  .map<MemberDetailsCard>(
                      (Stream<Member> member) => MemberDetailsCard(member))
                  .toList());
        }

        if (snapshot.hasError) Error404(msg: snapshot.error!.toString());

        return SpinKitCircle(color: dark);
      },
    );
  }
}
