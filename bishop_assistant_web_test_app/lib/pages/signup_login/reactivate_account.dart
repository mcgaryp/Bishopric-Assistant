import 'package:the_assistant/firebase/repositories/repositories.dart';
import 'package:the_assistant/widgets/widgets.dart';
import 'package:models/models/account.dart';

///
/// reactivate_account.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 12/9/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

class ReactivateAccount extends StatelessWidget {
  const ReactivateAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DarkPage(inputs: [
      Text(
        sReactivate,
        textAlign: TextAlign.center,
        style: subheadLight,
      )
    ], buttons: [
      MyButton(
          label: sYes,
          onPressed: () => _yes(context,
              ModalRoute.of(context)!.settings.arguments as AccountID)),
      MyButton(label: sNo, onPressed: () => _no(context)),
    ]);
  }

  void _no(BuildContext context) {
    Navigator.pushReplacementNamed(context, rLogin);
  }

  void _yes(BuildContext context, AccountID id) async {
    DefaultReactivateAccountUseCase useCase =
        DefaultReactivateAccountUseCase(FirestoreAccountRepository());
    if (await useCase.execute(id)) {
      MyToast.toastSuccess("Account Activated");
      Navigator.pushReplacementNamed(context, rLogin);
    } else
      MyToast.toastError("Account Failed to Reactivate");
  }
}
