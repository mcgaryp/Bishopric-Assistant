import 'package:bishop_assistant_web_test_app/widgets/widgets.dart';
import 'package:flutter/services.dart';
import 'package:models/models/account_domain/pin.dart';
import 'package:share_plus/share_plus.dart';

///
/// beta_pin_dialog.dart
/// bishopric-assistant
///
/// Created by Joshua Bee on 3/24/22
/// Copyright 2022 Joshua Bee. All rights reserved.
///

// todo Whenever we call this page we need to do the following:
// use the create_pin_use_case to add a pin to database
//

class BetaPinDialog extends StatelessWidget {
  final Pin pin;

  const BetaPinDialog({
    Key? key,
    required this.pin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
          child: Text(
        "Beta Invite Pin",
        style: largeTitle,
      )),
      content: Center(
        child: Text(pin.passcode, style: smallTitle),
      ),
      shape: roundedBorder,
      actions: [
        MyButton.icon(
          icon: Icon(Icons.copy), //copy
          onPressed: copyPressed,
        ),
        MyButton.icon(
          icon: Icon(Icons.share), //share button
          onPressed: sharePressed, //=> Navigator.pop(context),
        ),
      ],
    );
  }

  void copyPressed() {
    Clipboard.setData(ClipboardData(text: pin.passcode));
    MyToast.toastSuccess("Copied to clipboard!");
  }

  void sharePressed() {
    Share.share(pin.passcode);
  }
}
