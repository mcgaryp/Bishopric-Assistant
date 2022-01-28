import 'package:bishop_assistant_web_test_app/pages/organization/delete_organization_confirmation_dialog.dart';
import 'package:bishop_assistant_web_test_app/widgets/widgets.dart';

///
/// edit_organization.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 1/27/22
/// Copyright 2022 Porter McGary. All rights reserved.
///

class EditOrganization extends StatefulWidget {
  final void Function() onPress;

  const EditOrganization(this.onPress, {Key? key}) : super(key: key);

  @override
  State<EditOrganization> createState() => _EditOrganizationState();
}

class _EditOrganizationState extends State<EditOrganization> {
  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Row(
        children: [
          Flexible(
              child: InputField.border(
            StateContainer.of(context).organization.name,
            // TODO: Add controller and other needs
          )),
          MyButton(
            label: sSave,
            onPressed: () {
              // TODO: Save organization
              widget.onPress();
            },
            isExpanded: false,
            style: MyButtonStyle.text,
          ),
          MyButton(
            label: sDelete,
            onPressed: () => _confirmDeleteOrganization(context),
            isExpanded: false,
            style: MyButtonStyle.errorText,
          ),
        ],
      ),
    ]);
  }

  void _confirmDeleteOrganization(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) => ConfirmDeleteOrganizationDialog());
  }
}
