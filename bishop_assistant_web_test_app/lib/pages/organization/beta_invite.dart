import 'package:models/models/account.dart';
import 'package:the_assistant/firebase/repositories/firestore_pin_repository.dart';
import 'package:the_assistant/main.dart';
import 'package:the_assistant/widgets/dialogs/beta_pin_dialog.dart';
import 'package:the_assistant/widgets/widgets.dart';

///
/// beta_invite.dart
/// bishopric-assistant
///
/// Created by Joshua Bee on 3/24/22
/// Copyright 2022 Joshua Bee. All rights reserved.
///

class BetaInvite extends StatefulWidget {
  static PinRepository _pinRepository = FirestorePinRepository();

  @override
  State<BetaInvite> createState() => _BetaInviteState();
}

class _BetaInviteState extends State<BetaInvite> {
  CreatePinUseCase useCase = DefaultCreatePinUseCase(BetaInvite._pinRepository);

  @override
  Widget build(BuildContext context) {
    if (isBeta)
      return MyButton(
        label: sInviteBeta,
        onPressed: onPress,
        isExpanded: false,
      );
    else
      return Container();
  }

  Future<void> onPress() async {
    try {
      Pin pin = Pin();
      bool isCreated = await useCase.execute(pin: pin);
      if (isCreated)
        showDialog(
            context: context,
            builder: (BuildContext dialogContext) {
              return BetaPinDialog(pin: pin);
            });
    } catch (e) {
      MyToast.toastError(e);
      if (kDebugMode) print(e);
    }
  }
}
