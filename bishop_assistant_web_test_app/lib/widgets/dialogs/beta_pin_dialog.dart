import 'package:bishop_assistant_web_test_app/widgets/widgets.dart';
import 'package:flutter/foundation.dart';
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

class BetaPinDialog extends StatelessWidget {
  final Pin pin;

  const BetaPinDialog({
    Key? key,
    required this.pin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      title: Text(
        "Beta Invite Pin\n",
        style: subhead,
      ),
      content: Text(
        pin.passcode,
        style: largeTitle,
        textAlign: TextAlign.center,
      ),
      shape: roundedBorder,
      actions: [
        MyButton.icon(
          icon: Icon(
            Icons.copy,
            color: dark,
          ), // copy
          onPressed: copyPressed,
        ),
        MyButton.icon(
          icon: Icon(
            Icons.share,
            color: dark,
          ), // share button
          onPressed: sharePressed,
        ),
      ],
    );
  }

  void copyPressed() async {
    try {
      await Clipboard.setData(ClipboardData(text: url));
      MyToast.toastSuccess("Copied to clipboard!");
    } catch (e) {
      MyToast.toastError(e);
      if (kDebugMode) print(e);
    }
  }

  void sharePressed() {
    try {
      Share.share(url);
    } catch (e) {
      MyToast.toastError(e);
      if (kDebugMode) print(e);
    }
  }

  String get url {
    List<String> strings = Uri.base.toString().split("/");
    strings.removeLast();
    String str = strings.join("/");
    str += "/signup-beta/?pin=${pin.passcode}";
    return str;
  }
}
