import 'package:bishop_assistant_web_test_app/repositories/repositories.dart';
import 'package:bishop_assistant_web_test_app/util/util.dart';
import 'package:bishop_assistant_web_test_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:models/models/account.dart';
import 'package:models/models/organization.dart';

///
/// display_profile.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 12/9/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

class DisplayProfile extends StatelessWidget {
  final void Function() onEdit;
  const DisplayProfile(this.onEdit, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Account account = StateContainer.of(context).account;
    Organization? organization;
    bool hasOrganization = StateContainer.of(context).hasOrganization;
    if (hasOrganization) organization = StateContainer.of(context).organization;

    return Column(
      children: [
        CardRow(sEmail, content: account.contact.email),
        CardRow(sPhone, content: account.contact.phone),
        if (hasOrganization) CardRow(sOrganization, content: organization!.name),
        if (hasOrganization) CardRow(sCreator, content: organization!.creator.name.fullName),
        MyButton(label: sEdit, onPressed: onEdit),
        MyButton(
          label: sDeactivateAccount,
          onPressed: () => _deactivate(context),
          style: MyButtonStyle.error,
        )
      ],
    );
  }

  void _deactivate(context) async {
    try {
      Account account = StateContainer.of(context).account;
      DefaultDeleteAccountUseCase useCase =
          DefaultDeleteAccountUseCase(FirebaseAccountRepository());
      if (await useCase.execute(account.id, account.id)) {
        MyToast.toastSuccess("Deactivated Your Account");
        Navigator.pushReplacementNamed(context, rLogin);
      }
    } catch (e) {
      if (kDebugMode) print(e);
      MyToast.toastError(e.toString());
    }
  }
}
