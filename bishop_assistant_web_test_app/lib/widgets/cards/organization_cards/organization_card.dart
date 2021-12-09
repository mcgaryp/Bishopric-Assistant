import 'package:bishop_assistant_web_test_app/repositories/repositories.dart';
import 'package:bishop_assistant_web_test_app/theme/theme.dart';
import 'package:bishop_assistant_web_test_app/util/util.dart';
import 'package:bishop_assistant_web_test_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:models/models/account.dart';
import 'package:models/models/organization.dart';

///
/// organization_card.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 11/5/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

class OrganizationCard extends StatelessWidget {
  final Organization organization;

  const OrganizationCard({Key? key, required this.organization})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyCard(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            CardTitle(organization.name),
            Text(organization.creator.name.fullName, style: captionLight),
          ]),
          CardButton(sJoin, onPressed: () => _joinOrganization(context)),
        ],
      ),
    ]);
  }

  void _joinOrganization(BuildContext context) {
    MyToast.toastSuccess("pressed join");
    try {
      Account account = StateContainer.of(context).account;
      DefaultJoinOrganizationUseCase useCase =
          DefaultJoinOrganizationUseCase(FirebaseOrganizationRepository());
      useCase.execute(accountID: account.id, organizationID: organization.id);
      MyToast.toastSuccess(
          "${account.name.fullName}'s request to join ${organization.name} has been sent");
    } catch (e) {
      MyToast.toastError(e.toString());
    }
  }
}
