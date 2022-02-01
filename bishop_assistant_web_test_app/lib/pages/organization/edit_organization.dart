import 'package:bishop_assistant_web_test_app/pages/organization/delete_organization_confirmation_dialog.dart';
import 'package:bishop_assistant_web_test_app/repositories/repositories.dart';
import 'package:bishop_assistant_web_test_app/widgets/widgets.dart';
import 'package:models/models/organization.dart';

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

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          StateContainer.of(context).member ==
                  StateContainer.of(context).organization.creator
              ? Flexible(
                  child: InputField.floating(
                  StateContainer.of(context).organization.name,
                  controller: nameControl,
                ))
              : Text(
                  StateContainer.of(context).organization.name,
                  style: titleDark,
                ),
          Row(
            children: [
              MyButton(
                label: sSave,
                onPressed: () async => _changeOrganizationName(),
                isExpanded: false,
                style: MyButtonStyle.text,
              ),
              MyButton(
                label: sCancel,
                onPressed: widget.onPress,
                style: MyButtonStyle.text,
                isExpanded: false,
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
              FirebaseOrganizationRepository(), FirebaseMemberRepository());
      MemberID accessorId = StateContainer.of(context).member.id;
      if (await useCase.execute(
          accessorId: accessorId, name: nameControl.text)) {
        MyToast.toastSuccess(
            "Organization name changed to `${nameControl.text}`");
        widget.onPress();
      }
    } catch (e) {
      if (kDebugMode) print(e);
      MyToast.toastError(e.toString());
    }
  }
}
