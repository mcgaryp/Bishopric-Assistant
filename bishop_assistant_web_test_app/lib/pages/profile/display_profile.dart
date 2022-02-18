import 'package:bishop_assistant_web_test_app/repositories/repositories.dart';
import 'package:bishop_assistant_web_test_app/widgets/widgets.dart';
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
    if (StateContainer.of(context).state >= UserState.inOrganization)
      organization = StateContainer.of(context).organization;

    return Column(
      children: [
        CardRow(sEmail, content: account.contact.email),
        CardRow(sPhone, content: account.contact.phone),
        if (organization != null)
          CardRow(sOrganization, content: organization.name),
        if (organization != null)
          CardRow(sCreator, content: organization.creator.name.fullName),
        MyButton(label: sEdit, onPressed: onEdit),
        MyButton(
          label: sDeactivateAccount,
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext con) =>
                    ConfirmDeactivationDialog(() => _deactivate(con)));
          },
          style: MyButtonStyle.floatingError,
        )
      ],
    );
  }

  void _deactivate(context) async {
    try {
      Account account = StateContainer.of(context).account;
      DefaultDeactivateAccountUseCase useCase =
          DefaultDeactivateAccountUseCase(FirebaseAccountRepository());
      if (await useCase.execute(
          accessorID: account.id, accountID: account.id)) {
        MyToast.toastSuccess("Deactivated Your Account");
        Navigator.pushReplacementNamed(context, rLogin);
      }
    } catch (e) {
      if (kDebugMode) print(e);
      MyToast.toastError(e);
    }
  }
}

class ConfirmDeactivationDialog extends StatelessWidget {
  final void Function() onConfirm;

  const ConfirmDeactivationDialog(this.onConfirm, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConfirmationDialog(
        onConfirm: onConfirm,
        title: "Confirm Account Deactivation",
        content:
            "Are you sure you want to deactivate your account? Doing so will no "
            "longer give you or anyone else access to personal information "
            "and organizations.\n\nYou may reactivate your account when you "
            "verify your email address again.");
  }
}
