import 'package:bishop_assistant_web_test_app/firebase/new_repositories/repositories.dart';
import 'package:bishop_assistant_web_test_app/widgets/widgets.dart';
import 'package:models/models/organization.dart';

///
/// confirm_member_removal_dialog.dart
/// bishopric-assistant
///
/// Created by Po on 2/2/22
/// Copyright 2022 Po. All rights reserved.
///

class ConfirmMemberRemovalDialog extends StatelessWidget {
  final Member member;

  const ConfirmMemberRemovalDialog(this.member, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConfirmationDialog(
        onConfirm: () => _remove(context),
        title: sConfirmDelete,
        content:
            "Are you sure you would like to remove ${member.name}? Doing so will remove all assignments and events related to the member.");
  }

  void _remove(BuildContext context) async {
    try {
      RemoveMemberFromOrganizationUseCase useCase =
          DefaultRemoveMemberFromOrganizationUseCase(
              FirestoreMemberRepository(), FirestoreOrganizationRepository());

      if (await useCase.execute(
          accessorId: StateContainer.of(context).member.id,
          memberID: member.id)) {
        MyToast.toastSuccess("Removed ${member.name} from "
            "${StateContainer.of(context).organization.name}");
        Navigator.pop(context);
      }
    } catch (e) {
      if (kDebugMode) print(e);
      MyToast.toastError(e);
    }
  }
}
