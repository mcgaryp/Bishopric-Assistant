import 'package:models/models/organization.dart';
import 'package:the_assistant/firebase/repositories/repositories.dart';
import 'package:the_assistant/pages/organization/delete_organization_confirmation_dialog.dart';
import 'package:the_assistant/pages/organization/organization_members_view.dart';
import 'package:the_assistant/widgets/widgets.dart';

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
  TextEditingController nameControl = TextEditingController();
  String name = "";

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            StateContainer.of(context).member ==
                    StateContainer.of(context).organization.creator
                ? Flexible(
                    child: InputField.floating(
                    StateContainer.of(context).organization.name,
                    padding: 0,
                    controller: nameControl,
                    onChange: (String? str) {
                      setState(() {
                        name = str ?? "";
                      });
                      return str;
                    },
                    onSubmit: (String? str) {
                      _changeOrganizationName();
                    },
                  ))
                : Text(
                    StateContainer.of(context).organization.name,
                    style: titleDark,
                  ),
            Row(
              children: [
                MyButton(
                  label: name.isEmpty ? sCancel : sSave,
                  onPressed: () async => name.isEmpty
                      ? widget.onPress()
                      : _changeOrganizationName(),
                  isExpanded: false,
                  style: MyButtonStyle.text,
                ),
                if (StateContainer.of(context).member ==
                    StateContainer.of(context).organization.creator)
                  MyButton(
                    label: sDelete,
                    onPressed: () => _confirmDeleteOrganization(context),
                    isExpanded: false,
                    style: MyButtonStyle.errorText,
                  ),
              ],
            ),
          ],
        ),
      ),
      OrganizationMembersView(true),
    ]);
  }

  void _confirmDeleteOrganization(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) => ConfirmDeleteOrganizationDialog());
  }

  Future<void> _changeOrganizationName() async {
    try {
      if (nameControl.text.isEmpty) {
        widget.onPress();
        return;
      }
      ChangeOrganizationNameUseCase useCase =
          DefaultChangeOrganizationNameUseCase(
              FirestoreOrganizationRepository(), FirestoreMemberRepository());
      MemberID accessorId = StateContainer.of(context).member.id;
      if (await useCase.execute(
          accessorId: accessorId, name: nameControl.text)) {
        MyToast.toastSuccess(
            "Organization name changed to `${nameControl.text}`");
        widget.onPress();
      }
    } catch (e) {
      if (kDebugMode) print(e);
      MyToast.toastError(e);
    }
  }
}
