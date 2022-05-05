import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:models/models/account_domain/pin.dart';
import 'package:share_plus/share_plus.dart';
import 'package:the_assistant/widgets/widgets.dart';

///
/// beta_pin_dialog.dart
/// bishopric-assistant
///
/// Created by Joshua Bee on 3/24/22
/// Copyright 2022 Joshua Bee. All rights reserved.
///

class BetaPinDialog extends StatelessWidget {
  final Pin pin;
  late final BuildContext context;

  BetaPinDialog({
    Key? key,
    required this.pin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    this.context = context;

    return AlertDialog(
      title: Text(
        sBetaInvitePin,
        style: subhead,
        textAlign: TextAlign.center,
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
      await Clipboard.setData(ClipboardData(text: share));
      MyToast.toastSuccess("Copied to clipboard!");
    } catch (e) {
      MyToast.toastError(e);
      if (kDebugMode) print(e);
    }
  }

  void sharePressed() {
    try {
      Share.share(share);
    } catch (e) {
      MyToast.toastError(e);
      if (kDebugMode) print(e);
    }
  }

  String get share =>
      "${StateContainer.of(context).member.name.fullName} would like to invite "
      "you to join 'The Assistant Beta'\nClicking this link will take you "
      "to a signup page. Once registered and logged in request to join "
      "${StateContainer.of(context).organization.name}\n$url or Create an "
      "organization best fit for you.\nThis link will expire ${pin.expiration}"
      ".";

  // TODO: Add a linking mechanism
  //"<a href=${StateContainer.of(context).organization.name}'\n$url>Invite "
  //"Link</a>";

  String get url {
    List<String> strings = Uri.base.toString().split("/");
    strings.removeLast();
    String str = strings.join("/");
    str += "/signup-beta/?pin=${pin.passcode}";
    return str;
  }
}
