import 'package:models/models/organization.dart';
import 'package:the_assistant/pages/organization/beta_invite.dart';
import 'package:the_assistant/pages/organization/organization_members_view.dart';
import 'package:the_assistant/pages/organization/organization_requests_view.dart';
import 'package:the_assistant/widgets/widgets.dart';

///
/// display_organization.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 1/27/22
/// Copyright 2022 Porter McGary. All rights reserved.
///

class DisplayOrganization extends StatelessWidget {
  final void Function() onPress;

  const DisplayOrganization(this.onPress, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Organization organization;
    Member member;

    organization = StateContainer.of(context).organization;
    member = StateContainer.of(context).member;

    return ListView(children: [
      Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                Text(
                  organization.name,
                  style: title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                if (member.role.authorization.rank >= 0)
                  MyButton(
                      label: sEdit,
                      onPressed: onPress,
                      isExpanded: false,
                      style: MyButtonStyle.smallText),
              ],
            ),
          ),
          Spacer(),
          BetaInvite(),
          OrganizationRequestsView(),
        ],
      ),
      OrganizationMembersView(false)
    ]);
  }
}
