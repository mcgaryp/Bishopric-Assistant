import 'package:bishop_assistant_web_test_app/repositories/repositories.dart';
import 'package:bishop_assistant_web_test_app/util/util.dart';
import 'package:bishop_assistant_web_test_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:models/models/account.dart';
import 'package:models/shared/dart_foundation.dart';

///
/// Pin.dart
/// bishop_assistant_web_test_app
///
/// Created by Porter McGary on 8/13/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

/// [PinView] user interface to submit a pin that is then verified
class PinView extends StatefulWidget {
  const PinView({Key? key}) : super(key: key);

  @override
  State<PinView> createState() => _PinViewState();
}

class _PinViewState extends State<PinView> {
  TextEditingController controller = TextEditingController();
  bool _isWaiting = false;
  late Pin pin;
  late String username;

  @override
  Widget build(BuildContext context) {
    try {
      final Map args = ModalRoute.of(context)!.settings.arguments as Map;
      pin = args["pin"] as Pin;
      username = args["username"] as String;
    } catch (e) {
      if (kDebugMode) print(e);
      return Error404Page();
    }

    return DarkPage(showSpinner: _isWaiting, inputs: [
      InputField.floating(
        sPin,
        controller: controller,
        onSubmit: _onSubmit,
      ),
    ], buttons: [
      AbsorbPointer(
        absorbing: _isWaiting,
        child: MyButton(
            label: sConfirmPin,
            onPressed: () =>
                Navigator.pushReplacementNamed(context, rChangePassword)),
      ),
    ]);
  }

  void _onSubmit(String? str) => _onPress();

  void _onPress() async {
    _setIsWaiting(true);

    if (pin.isValid(controller.text))
      await _lookUpCredentials();
    else
      _error();

    _setIsWaiting(false);
  }

  void _setIsWaiting(bool val) => setState(() => _isWaiting = val);

  Future<void> _lookUpCredentials() async {
    try {
      DefaultConfirmPinUseCase confirmPinUseCase =
          DefaultConfirmPinUseCase(FirebaseAccountRepository());
      Result<AccountID> result = await confirmPinUseCase.execute(username);
      if (result.isError) _error(msg: result.asError!.error.toString());
      if (result.isValue) _success(result.asValue!.value);
    } catch (e) {
      if (kDebugMode) print(e);
      _error(msg: e.toString());
    }
  }

  void _error({String? msg}) =>
      MyToast.toastError(msg ?? "Failed to enter correct pin");

  void _success(AccountID id) {
    Navigator.pushReplacementNamed(context, rChangePassword,
        arguments: {"accountID": id});
  }
}
