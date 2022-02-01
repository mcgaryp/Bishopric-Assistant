import 'package:bishop_assistant_web_test_app/pages/home/home.dart';
import 'package:bishop_assistant_web_test_app/pages/signup_login/login_page.dart';
import 'package:bishop_assistant_web_test_app/widgets/widgets.dart';
import 'package:models/models/account.dart';

///
/// home_page.dart
/// bishop_assistant_web_test_app
///
/// Created by Porter McGary on 8/13/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

/// [HomePage] is the landing page for the app when the user first logs in
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Ensure the account is properly created
    // Check to see if the user has an organization linked to their
    // account. If not then invite the user to find one
    StateContainerState state = StateContainer.of(context);
    switch (state.state) {
      case UserState.unauthenticated:
        return LoginPage();
      case UserState.noOrganization:
        return LightPage(child: FindOrganizationPage());
      case UserState.inOrganization:
        return LightPage(child: Container());
      default:
        return Error404Page(msg: "Unknown UserState");
    }
  }
}
