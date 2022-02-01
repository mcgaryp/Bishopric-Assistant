import 'package:bishop_assistant_web_test_app/repositories/repositories.dart';
import 'package:bishop_assistant_web_test_app/widgets/widgets.dart';
import 'package:models/models/organization.dart';

///
/// delete_organization_confirmation_dialog.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 1/28/22
/// Copyright 2022 Porter McGary. All rights reserved.
///

class ConfirmDeleteOrganizationDialog extends StatelessWidget {
  const ConfirmDeleteOrganizationDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConfirmationDialog(
      title: "Confirm Delete",
      content: "Are you sure that you want to delete "
          "`${StateContainer.of(context).organization.name}`? Removing the "
          "organization will delete all member, assignment, and event "
          "information.",
      onConfirm: () => _deleteOrganization(context),
    );
  }

  void _deleteOrganization(BuildContext context) async {
    try {
      DeleteOrganizationUseCase useCase = DefaultDeleteOrganizationUseCase(
          FirebaseOrganizationRepository(),
          FirebaseMemberRepository(),
          FirebaseAssignmentRepo(),
          FirebaseEventRepo());
      MemberID creatorID = StateContainer.of(context).member.id;
      OrganizationID organizationID =
          StateContainer.of(context).organization.id;
      String name = StateContainer.of(context).organization.name;
      StateContainer.of(context).nullOrganization();
      if (await useCase.execute(
          creatorID: creatorID, organizationID: organizationID)) {
        await StateContainer.of(context).findOrganization();
        MyToast.toastSuccess("Deleted $name");
        Navigator.pushReplacementNamed(context, rHome);
        return;
      }
    } catch (e) {
      if (kDebugMode) print(e);
      MyToast.toastError(e.toString());
    }
    await StateContainer.of(context).findOrganization();
  }
}
