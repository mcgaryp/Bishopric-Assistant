import 'package:bishop_assistant_web_test_app/firebase/new_repositories/firestore_organization_repository.dart';
import 'package:bishop_assistant_web_test_app/firebase/new_repositories/repositories.dart';
import 'package:bishop_assistant_web_test_app/pages/home/create_organization.dart';
import 'package:bishop_assistant_web_test_app/pages/home/list_of_organizations.dart';
import 'package:bishop_assistant_web_test_app/widgets/widgets.dart';
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
class FindOrganizationPage extends StatefulWidget {
  @override
  State<FindOrganizationPage> createState() => _FindOrganizationPageState();
}

class _FindOrganizationPageState extends State<FindOrganizationPage> {
  List<Organization>? organizations = [];
  Widget? errors;

  @override
  Widget build(BuildContext context) {

    return StreamBuilder(
        stream: FirestoreOrganizationRepository().allStreamed(),
        builder:
            (BuildContext context, AsyncSnapshot<List<Organization>> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            List<Organization> allOrganizations = snapshot.data!;

            if (organizations != null && organizations!.isEmpty)
              organizations = allOrganizations;

            return Padding(
              padding: const EdgeInsets.only(top: padding8),
              child: ListView(children: [
                CreateOrganization(() async {
                  await StateContainer.of(context).findOrganization();
                  Navigator.of(context).pushReplacementNamed(rHome);
                }),
                SearchBar<Organization>(
                  filter: (Organization org, String? str) {
                    if (str == null) return false;
                    return org.name.toLowerCase().contains(str.toLowerCase());
                  },
                  onChange: (Result<List<Organization>> result) {
                    if (result.isError) {
                      setState(() {
                        errors =
                            Error404(msg: result.asError!.error.toString());
                        organizations = null;
                      });
                    } else {
                      setState(() {
                        organizations = result.asValue!.value;
                        if (errors != null) errors = null;
                      });
                    }
                  },
                  searchableItems: allOrganizations,
                ),
                MyDivider(color: dark),
                errors ?? Container(),
                if (organizations != null) ListOfOrganizations(organizations!),
              ]),
            );
          }

          if (snapshot.hasError)
            return Error404(msg: snapshot.error.toString());

          return SpinKitCircle(color: dark);
        });
  }
}
