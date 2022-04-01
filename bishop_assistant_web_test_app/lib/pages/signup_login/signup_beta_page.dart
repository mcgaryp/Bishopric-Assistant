import 'package:the_assistant/firebase/repositories/firestore_pin_repository.dart';
import 'package:the_assistant/pages/signup_login/sign_up_page.dart';
import 'package:the_assistant/widgets/widgets.dart';
import 'package:models/models/account.dart';
import 'package:models/shared/exceptions/exceptions.dart';

///
/// signup_beta_page.dart
/// bishopric-assistant
///
/// Created by Joshua Bee on 3/16/22
/// Copyright 2022 Joshua Bee. All rights reserved.
///

class SignupBetaPage extends StatefulWidget {
  const SignupBetaPage({Key? key}) : super(key: key);

  @override
  State<SignupBetaPage> createState() => _SignupBetaPageState();
}

class _SignupBetaPageState extends State<SignupBetaPage> {
  // to tell us whether or not the pin they enter is good
  bool isAuthenticated = false;
  bool _isWaiting = false;

  TextEditingController pinControl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: Add Strings to string.dart
    // TODO: Create class that handles the get of a pin... maybe pin does this
    List<String> strings = Uri.base.toString().split("?pin=");
    if (strings.length > 1) {
      return FutureBuilder<bool>(
        future: _auth(strings.last),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasError) return Error404Page(msg: snapshot.error);
          if (snapshot.hasData) {
            if (snapshot.data!) {
              return SignupPage();
            } else {
              return standard;
            }
          }
          return DarkPage(showSpinner: true);
        },
      );
    } else {
      return standard;
    }
  }

  Widget get standard {
    if (!isAuthenticated)
      return DarkPage(
        inputs: [
          // TODO: enforce number only
          InputField.floating(
            sPin,
            controller: pinControl,
          )
        ],
        buttons: [
          AbsorbPointer(
            absorbing: _isWaiting,
            child: MyButton(
              label: "Confirm Pin",
              onPressed: onPress,
            ),
          )
        ],
      );
    return SignupPage();
  }

  Future<void> onPress() async {
    setState(() {
      _isWaiting = true;
    });

    bool value = await _authenticate(pinControl.text);

    setState(() {
      isAuthenticated = value;
      _isWaiting = false;
    });
  }

  Future<bool> _auth(String pin) async {
    await Future.delayed(Duration(seconds: 1));
    return _authenticate(pin);
  }
  Future<bool> _authenticate(String pin) async {
    try {
      PinRepository pinRepository = FirestorePinRepository();
      AuthenticatePinUseCase useCase =
          DefaultAuthenticatePinUseCase(pinRepository);
      return await useCase.execute(pinID: PinID(pin));
    } on PermissionDeniedError catch (e) {
      MyToast.toastError(e);
      if (kDebugMode) print(e);
    } catch (err) {
      MyToast.toastError("That pin is incorrect, try again");
      if (kDebugMode) print(err);
    }
    return false;
  }
}
