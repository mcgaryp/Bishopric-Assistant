import 'package:bishop_assistant_web_test_app/database/old_models_deprecated.dart';
import 'package:bishop_assistant_web_test_app/pages/home/home.dart';
import 'package:bishop_assistant_web_test_app/repositories/firebase_member_repository.dart';
import 'package:bishop_assistant_web_test_app/state/state_container.dart';
import 'package:bishop_assistant_web_test_app/theme/Colors.dart';
import 'package:bishop_assistant_web_test_app/widgets/cards/event_cards/EventCard.dart';
import 'package:bishop_assistant_web_test_app/widgets/page_support/page_support.dart';
import 'package:flutter/scheduler.dart';
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

  final List<EventCard> eventsList = [
    EventCard(Meeting.example1),
    EventCard(Meeting.example2),
    EventCard(Interview.example1),
    EventCard(Meeting.example3),
    EventCard(Interview.example2)
  ];

  static Organization tempOrganization = Organization(
      id: OrganizationID("Temporary Organization"),
      name: "Temporary Organization",
      creator: Member(
          name: Name(first: "Temp", last: "Creator"),
          memberID: MemberID("Temp Creator"),
          contact: Contact(email: "temp@creator.com", phone: "(123) 456-7894"),
          role: Role.creator()));

  final List<Organization> lst = List.filled(20, tempOrganization);

  @override
  Widget build(BuildContext context) {
    // Ensure the account is properly created
    // Check to see if the user has an organization linked to their
    // account. If not then invite the user to find one
    return FutureBuilder(
        future: _accountHasOrganization(context),
        builder: (BuildContext context,
            AsyncSnapshot<Result<Organization?>> snapshot) {
          if (snapshot.hasData) {
            SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
              StateContainer.of(context)
                  .setOrganization(snapshot.data!.asValue!.value);
            });
            if (snapshot.data!.asValue!.value != null)
              return ScreenTypeLayout(
                mobile: HomeMobile(
                    eventsList,
                    Assignment.assignmentExampleCardList,
                    OldMember.exampleMemberCardList),
                desktop: HomeWeb(
                    eventsList,
                    Assignment.assignmentExampleCardList,
                    OldMember.exampleMemberCardList),
              );

            return FindOrganizationPage();
          }

          if (snapshot.hasError) return Error404Page();

          return SpinKitCircle(color: dark);
        });
  }

  /// [_accountHasOrganization] checks to ensure that the user has an
  /// organization linked to the account returning true if so and false if not
  Future<Result<Organization?>> _accountHasOrganization(
      BuildContext context) async {
    AccountID accountID = StateContainer.of(context).account.id;

    try {
      DefaultHasAssociatedOrganizationUseCase useCase =
          DefaultHasAssociatedOrganizationUseCase(FirebaseMemberRepository());
      Organization? org = await useCase.execute(accountID: accountID);
      return Result.value(org);
    } catch (e) {
      if (kDebugMode) print(e);
    }

    return Result.value(null);
  }
}
