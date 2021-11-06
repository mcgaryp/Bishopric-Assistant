import 'package:bishop_assistant_web_test_app/util/util.dart';
import 'package:bishop_assistant_web_test_app/widgets/cards/card_support/MyCard.dart';
import 'package:bishop_assistant_web_test_app/widgets/cards/organization_cards/organization_card.dart';
import 'package:bishop_assistant_web_test_app/widgets/widgets.dart';
import 'package:flutter/widgets.dart';
import 'package:models/models/organization.dart';
import 'package:responsive_builder/responsive_builder.dart';

///
/// find_organization_page.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 11/5/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

class FindOrganizationPage extends Mobile {
  final List<Organization> organizations;

  FindOrganizationPage(this.organizations);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
        mobile: LightPage.mobileAction(
            ListOfOrganizations.mobile(organizations), ""),
        desktop: LightPage.web(
            [ListOfOrganizations.web(organizations), CreateOrganization()]));
  }
}

class ListOfOrganizations extends Mobile {
  final List<Organization> organizations;
  late final bool isWeb;

  ListOfOrganizations.mobile(this.organizations) {
    isWeb = false;
  }

  ListOfOrganizations.web(this.organizations) {
    isWeb = true;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    organizations.forEach(
        (element) => children.add(OrganizationCard(organization: element)));
    if (isWeb)
      return WebContentSnapShot(title: organizationsStr, children: children);
    return MobileContentSnapShot([Section(organizationsStr, children)]);
  }
}

class CreateOrganization extends Mobile {
  @override
  Widget build(BuildContext context) {
    return WebContentSnapShot(title: createOrganization, children: [
      MyCard(children: [
        InputField.border("Name of Organization"),
        MyButton(label: create, onPressed: _createOrganization)
      ])
    ]);
  }

  void _createOrganization() {
    // TODO: Implement
  }
}
