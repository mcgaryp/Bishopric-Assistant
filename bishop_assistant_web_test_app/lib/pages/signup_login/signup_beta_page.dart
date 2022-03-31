import 'package:bishop_assistant_web_test_app/firebase/repositories/firestore_pin_repository.dart';
import 'package:bishop_assistant_web_test_app/pages/signup_login/sign_up_page.dart';
import 'package:bishop_assistant_web_test_app/widgets/widgets.dart';
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
  bool isAuthenticated =
      false; //to tell us whether or not the pin they enter is good
  bool _isWaiting = false;

  TextEditingController pinControl = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!isAuthenticated)
      return DarkPage(
        inputs: [
          InputField.floating(
            sPin,
            controller: pinControl,
          )
        ], //TODO enforce number only maybe?
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

  void onPress() async {
    try {
      PinRepository pinRepository = FirestorePinRepository();
      AuthenticatePinUseCase useCase =
          DefaultAuthenticatePinUseCase(pinRepository);
      bool isValid = await useCase.execute(pinID: PinID(pinControl.text));
      setState(() {
        isAuthenticated = isValid;
      });
    } on PermissionDeniedError catch (e) {
      MyToast.toastError(e);
    } catch (err) {
      MyToast.toastError("That pin is incorrect, try again");
      if (kDebugMode) print(err);
    }
  }
}
