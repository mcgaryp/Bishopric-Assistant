import 'package:bishop_assistant_web_test_app/pages/organization/organization_members_view.dart';
import 'package:bishop_assistant_web_test_app/pages/organization/organization_requests_view.dart';
import 'package:bishop_assistant_web_test_app/widgets/widgets.dart';
import 'package:models/models/organization.dart';

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
    return ListView(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                StateContainer.of(context).organization.name,
                style: titleDark,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              if (StateContainer.of(context).member.role.permissions >=
                  Permissions.Maintainer)
                MyButton(
                    label: sEdit,
                    onPressed: onPress,
                    isExpanded: false,
                    style: MyButtonStyle.darkText),
            ],
          ),
          OrganizationRequestsView(),
        ],
      ),
      OrganizationMembersView(false)
    ]);
  }
}
