import 'package:bishop_assistant_web_test_app/database/old_models_deprecated.dart';
import 'package:bishop_assistant_web_test_app/navigation/route_strings.dart';
import 'package:bishop_assistant_web_test_app/pages/home/home.dart';
import 'package:bishop_assistant_web_test_app/repositories/repositories.dart';
import 'package:bishop_assistant_web_test_app/theme/Colors.dart';
import 'package:bishop_assistant_web_test_app/util/MyToast.dart';
import 'package:bishop_assistant_web_test_app/widgets/cards/event_cards/EventCard.dart';
import 'package:bishop_assistant_web_test_app/widgets/page_support/page_support.dart';
import 'package:models/models/account.dart';
import 'package:models/shared/foundation.dart';
import 'package:responsive_builder/responsive_builder.dart';

///
/// home_page.dart
/// bishop_assistant_web_test_app
///
/// Created by Porter McGary on 8/13/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

/// [HomePage] is the landing page for the app when the user first logs in
class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final List<EventCard> eventsList = [
    EventCard(Meeting.example1),
    EventCard(Meeting.example2),
    EventCard(Interview.example1),
    EventCard(Meeting.example3),
    EventCard(Interview.example2)
  ];

  @override
  Widget build(BuildContext context) {
    // The status of the user needs to be checked to ensure they have
    // authenticated access to the application. This future allows a clean
    // transitions of the display while the login is being authenticated
    return FutureBuilder<Account?>(
      future: _checkLoginStatus(context),
      builder: (BuildContext futureContext, AsyncSnapshot<Account?> snapshot) {
        // Ensure the account is properly created
        if (snapshot.hasData) if (snapshot.data != null) {
          Account account = snapshot.data!;
          // Check to see if the user has an organization linked to their
          // account. If not then invite the user to find one
          if (_accountHasOrganization(account))
            return ScreenTypeLayout(
              mobile: HomeMobile(
                  eventsList,
                  Assignment.assignmentExampleCardList,
                  Member.exampleMemberCardList),
              desktop: HomeWeb(eventsList, Assignment.assignmentExampleCardList,
                  Member.exampleMemberCardList),
            );
          return LightPage.both(FindOrganizationPage());
        }

        // Display any errors
        if (snapshot.hasError) return Error404Page();

        // Load a temporary loading screen for the user
        return SpinKitCircle(color: dark);
      },
    );
  }

  /// [_checkLoginStatus] ensures that the user is logged in. If this is the
  /// case account will be parsed from the cache and return it to the caller
  Future<Account?> _checkLoginStatus(BuildContext context) async {
    Account? account;
    try {
      FirebaseAccountRepository _repository = FirebaseAccountRepository();
      DefaultIsLoggedInUseCase isLoggedIn =
          DefaultIsLoggedInUseCase(_repository);
      Result<Account> result = await isLoggedIn.execute();
      if (result.isError) {
        MyToast.toastError(result.asError!.error.toString());
        if (kDebugMode) print(result.asError!.error);
        throw result.asError!.error;
      }

      if (result.isValue) {
        account = result.asValue!.value;
      }

      if (account == null)
        WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
          Navigator.pushReplacementNamed(context, rLogin);
        });
    } catch (e) {
      MyToast.toastError(e.toString());
      if (kDebugMode) print(e);
      throw e;
    }
    return account;
  }

  /// [_accountHasOrganization] checks to ensure that the user has an
  /// organization linked to the account returning true if so and false if not
  bool _accountHasOrganization(Account account) {
    // TODO: Implement
    return false;
  }
}
