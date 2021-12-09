import 'package:bishop_assistant_web_test_app/pages/home/home.dart';
import 'package:bishop_assistant_web_test_app/repositories/firebase_member_repository.dart';
import 'package:bishop_assistant_web_test_app/state/state_container.dart';
import 'package:bishop_assistant_web_test_app/theme/Colors.dart';
import 'package:bishop_assistant_web_test_app/widgets/page_support/page_support.dart';
import 'package:models/models/account.dart';
import 'package:models/models/organization.dart';
import 'package:models/models/organization_domain/organization_use_case.dart';
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

  @override
  Widget build(BuildContext context) {
    // Ensure the account is properly created
    // Check to see if the user has an organization linked to their
    // account. If not then invite the user to find one
    // TODO: Add assignments, events, and organization members
    return FutureBuilder(
        future: _accountHasOrganization(context),
        builder: (BuildContext context,
            AsyncSnapshot<Result<OrganizationMember?>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.asValue!.value != null)
              return ScreenTypeLayout(
                mobile: HomeMobile([], [], []),
                desktop: HomeWeb([], [], []),
              );

            return FindOrganizationPage();
          }

          if (snapshot.hasError) return Error404Page();

          return SpinKitCircle(color: dark);
        });
  }

  /// [_accountHasOrganization] checks to ensure that the user has an
  /// organization linked to the account returning true if so and false if not
  Future<Result<OrganizationMember?>> _accountHasOrganization(
      BuildContext context) async {
    AccountID accountID = StateContainer.of(context).account.id;
    try {
      DefaultHasAssociatedOrganizationUseCase useCase =
          DefaultHasAssociatedOrganizationUseCase(FirebaseMemberRepository());
      OrganizationMember? org = await useCase.execute(accountID: accountID);
      StateContainer.of(context).setOrganization(org);
      return Result.value(org);
    } catch (e) {
      if (kDebugMode) print(e);
    }

    return Result.value(null);
  }
}
