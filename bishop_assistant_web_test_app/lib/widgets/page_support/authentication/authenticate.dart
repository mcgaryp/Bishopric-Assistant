import 'package:the_assistant/pages/signup_login/login_page.dart';
import 'package:the_assistant/widgets/widgets.dart';
import 'package:models/models/account.dart';

///
/// authenticate.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 12/1/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

class Authenticate extends StatelessWidget {
  final Widget child;

  const Authenticate({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // The status of the user needs to be checked to ensure they have
    // authenticated access to the application.
    UserState state = StateContainer.of(context).state;
    if (state >= UserState.authenticated) return child;
    if (state == UserState.loadingIn)
      return DarkPage(inputs: [], buttons: [], showSpinner: true);
    return LoginPage();
  }
}
