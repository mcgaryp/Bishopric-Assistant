import 'package:bishop_assistant_web_test_app/repositories/repositories.dart';
import 'package:bishop_assistant_web_test_app/state/state_container.dart';
import 'package:bishop_assistant_web_test_app/theme/Decorations.dart';
import 'package:bishop_assistant_web_test_app/theme/Topography.dart';
import 'package:bishop_assistant_web_test_app/util/util.dart';
import 'package:bishop_assistant_web_test_app/widgets/cards/card_support/card_action_button.dart';
import 'package:bishop_assistant_web_test_app/widgets/my_dropdown.dart';
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

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(widget.details.request.id.id),
      background: Container(color: Colors.red),
      onDismissed: (direction) {
        _reject();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: padding4),
        child: Container(
          decoration: darkBorderBox,
          child: Padding(
            padding: const EdgeInsets.all(padding8),
            child: Column(
              children: [
                Text(widget.details.name.fullName, style: subheadDark),
                MyDropdown(
                    hint: sRole,
                    validator: Validators.validateDropDown,
                    collection: Permissions.values
                        .map<DropdownMenuItem<int>>((e) => DropdownMenuItem(
                            child: Text(e.string), value: e.index))
                        .toList(),
                    onchange: _onRoleSelected),
                Row(
                  children: [
                    CardActionButton("Accept", onPressed: _accept),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onRoleSelected(int? value) {
    if (value == null)
      throw PermissionDeniedError(
          reason: "Must select a role to accept new member");
    setState(() {
      Permissions permission = Permissions.values[value];
      role = Role(permission, anonymous: permission.string);
    });
  }

  void _accept() async {
    try {
      if (role == null)
        throw PermissionDeniedError(
            reason: "Must select a role to accept new member");
      DefaultAddMemberToOrganizationUseCase useCase =
          DefaultAddMemberToOrganizationUseCase(FirebaseAccountRepository(),
              FirebaseOrganizationRepository(), FirebaseMemberRepository());

      await useCase.execute(
          accessorId: StateContainer.of(context).member.memberID,
          request: widget.details.request,
          role: role!);

      MyToast.toastSuccess(
          "Successfully added ${widget.details.name.fullName}");
    } catch (e) {
      if (kDebugMode) print(e);
      MyToast.toastError(e.toString());
    }
  }

  void _reject() {
    try {
      DefaultRejectRequestUseCase useCase =
          DefaultRejectRequestUseCase(FirebaseOrganizationRepository());
      useCase.execute(widget.details.request);
      MyToast.toastSuccess(
          "Rejected ${widget.details.name.fullName}'s Request");
    } catch (e) {
      if (kDebugMode) print(e);
      MyToast.toastError(e.toString());
    }
  }
}
