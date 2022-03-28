import 'package:bishop_assistant_web_test_app/firebase/new_repositories/repositories.dart';
import 'package:bishop_assistant_web_test_app/widgets/widgets.dart';
import 'package:models/models/organization.dart';
import 'package:models/shared/foundation.dart';

///
/// join_request_detail_view.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 12/9/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

class JoinRequestDetailsView extends StatefulWidget {
  final JoinRequestDetail details;

  JoinRequestDetailsView(this.details, {Key? key}) : super(key: key);

  @override
  State<JoinRequestDetailsView> createState() => _JoinRequestDetailsViewState();
}

class _JoinRequestDetailsViewState extends State<JoinRequestDetailsView> {
  Role? role;
  late List<Role> roles;

  @override
  Widget build(BuildContext context) {
    roles = StateContainer.of(context).roles;

    return MyCard(
        child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: padding8),
          child: Text(widget.details.name.fullName, style: subhead),
        ),
        MyDropdown(
            hint: sRole,
            validator: Validators.validateDropDown,
            collection: roles
                .map<DropdownMenuItem<int>>((Role role) =>
                    DropdownMenuItem(
                        child: Text(role.name),
                        value: role.id.id.hashCode))
                .toList(),
            onchange: _onRoleSelected),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            MyButton(
              label: sReject,
              onPressed: _reject,
              style: MyButtonStyle.errorText,
              isExpanded: false,
            ),
            MyButton(
              label: sAccept,
              onPressed: _accept,
              isExpanded: false,
              style: MyButtonStyle.text,
            ),
          ],
        ),
      ],
    ));
  }

  void _onRoleSelected(int? value) {
    if (value == null)
      throw PermissionDeniedError(
          reason: "Must select a role to accept new member");
    setState(() {
      role = roles.find(value);
    });
  }

  void _accept() async {
    try {
      if (role == null)
        throw PermissionDeniedError(
            reason: "Must select a role to accept new member");
      DefaultAddMemberToOrganizationUseCase useCase =
          DefaultAddMemberToOrganizationUseCase(
        FirestoreAccountRepository(),
        FirestoreOrganizationRepository(),
        FirestoreMemberRepository(),
        FirestoreJoinRequestRepository(),
      );

      await useCase.execute(
          accessorId: StateContainer.of(context).member.id,
          request: widget.details.request,
          role: role!);

      MyToast.toastSuccess(
          "Successfully added ${widget.details.name.fullName}");
    } catch (e) {
      if (kDebugMode) print(e);
      MyToast.toastError(e);
    }
  }

  void _reject() {
    try {
      DefaultRejectRequestUseCase useCase =
          DefaultRejectRequestUseCase(FirestoreJoinRequestRepository());
      useCase.execute(widget.details.request.id);
      MyToast.toastSuccess(
          "Rejected ${widget.details.name.fullName}'s Request");
    } catch (e) {
      if (kDebugMode) print(e);
      MyToast.toastError(e);
    }
  }
}
