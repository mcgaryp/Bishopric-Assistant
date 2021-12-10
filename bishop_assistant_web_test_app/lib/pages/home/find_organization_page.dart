import 'package:bishop_assistant_web_test_app/pages/home/create_organization.dart';
import 'package:bishop_assistant_web_test_app/pages/home/list_of_organizations.dart';
import 'package:bishop_assistant_web_test_app/repositories/repositories.dart';
import 'package:bishop_assistant_web_test_app/theme/theme.dart';
import 'package:bishop_assistant_web_test_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:models/models/organization.dart';

///
/// find_organization_page.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 11/5/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

/// [FindOrganizationPage] Handles the organization loading and managing mobile
/// and web versions
class FindOrganizationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DefaultAllOrganizationsUseCase useCase =
        DefaultAllOrganizationsUseCase(FirebaseOrganizationRepository());

    return StreamBuilder(
        stream: useCase.execute(),
        builder:
            (BuildContext context, AsyncSnapshot<List<Organization>> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            List<Organization> organizations = snapshot.data!;
            return LightPage(
                child: Column(children: [
              CreateOrganization(),
              ListOfOrganizations(organizations),
            ]));
          }

          if (snapshot.hasError)
            return Error404Page(msg: snapshot.error.toString());

          return SpinKitCircle(color: dark);
        });
  }
}
