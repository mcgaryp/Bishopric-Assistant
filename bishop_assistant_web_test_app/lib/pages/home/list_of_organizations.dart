import 'package:the_assistant/widgets/widgets.dart';
import 'package:models/models/organization.dart';

///
/// list_of_organizations.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 12/9/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

/// [ListOfOrganizations] shows the list of organizations available to join
class ListOfOrganizations extends StatelessWidget {
  final List<Organization> organizations;

  const ListOfOrganizations(this.organizations, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    organizations.forEach(
        (element) => children.add(OrganizationCard(organization: element)));
    return Column(children: children);
  }
}
