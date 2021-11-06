import 'package:bishop_assistant_web_test_app/theme/Topography.dart';
import 'package:bishop_assistant_web_test_app/util/util.dart';
import 'package:bishop_assistant_web_test_app/widgets/cards/card_support/CardButton.dart';
import 'package:bishop_assistant_web_test_app/widgets/cards/card_support/CardTitle.dart';
import 'package:bishop_assistant_web_test_app/widgets/cards/card_support/MyCard.dart';
import 'package:bishop_assistant_web_test_app/widgets/page_support/page_support.dart';
import 'package:models/models/organization.dart';

///
/// organization_card.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 11/5/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

class OrganizationCard extends StatelessWidget {
  final Organization organization;

  const OrganizationCard({Key? key, required this.organization})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyCard(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            CardTitle(organization.name),
            Text(organization.creator.name.name, style: captionLight),
          ]),
          CardButton(join, onPressed: _joinOrganization),
        ],
      ),
    ]);
  }

  void _joinOrganization() {
    // TODO: Implement
  }
}
