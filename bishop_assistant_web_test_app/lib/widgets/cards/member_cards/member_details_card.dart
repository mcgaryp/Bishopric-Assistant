import 'package:bishop_assistant_web_test_app/repositories/repositories.dart';
import 'package:bishop_assistant_web_test_app/widgets/widgets.dart';
import 'package:models/models/organization.dart';
import 'package:models/shared/exceptions.dart';

///
/// member_details_card_.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 1/29/22
/// Copyright 2022 Porter McGary. All rights reserved.
///

class MemberDetailsCard extends StatefulWidget {
  final Member member;
  const MemberDetailsCard(this.member, {Key? key}) : super(key: key);

  @override
  State<MemberDetailsCard> createState() => _MemberDetailsCardState();
}

class _MemberDetailsCardState extends State<MemberDetailsCard> {
  bool isEditing = false;
  Role? role;

  @override
  Widget build(BuildContext context) {
    Permissions permissions = widget.member.role.permissions;

    return MyCard(
      child: ExpansionTile(
          maintainState: true,
          title: MemberTitle(widget.member),
          children: [
            if (permissions > Permissions.maintainer)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (!isEditing) Spacer(),
                  if (isEditing)
                    MyConstrainedBox200(
                      child: MyDropdown(
                          padding: 0,
                          hint: sRole,
                          validator: Validators.validateDropDown,
                          collection: Permissions.values
                              .map<DropdownMenuItem<int>>((e) =>
                                  DropdownMenuItem(
                                      child: Text(e.string), value: e.index))
                              .toList(),
                          onchange: _onRoleSelected),
                    ),
                  if (StateContainer.of(context).organization.creator !=
                      widget.member)
                    Align(
                        alignment: Alignment.centerRight,
                        child: MyButton(
                            label: isEditing ? sSave : sEdit,
                            onPressed: () {
                              if (isEditing == true) {
                                _save();
                              }
                              _setIsEditing(!isEditing);
                            })),
                ],
              ),
            MyDivider(color: darkPrimary),
            CardRow(sEmail, content: widget.member.contact.email),
            CardRow(sPhone, content: widget.member.contact.phone),
            CardRow(sCurrentAssignmentCount, content: "1"),
            CardRow(sCurrentEventCount, content: "2"),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                MyButton(
                  label: sCreateEvent,
                  onPressed: () {},
                  isExpanded: false,
                ),
                MyButton(
                  label: sCreateAssignment,
                  onPressed: () {},
                  isExpanded: false,
                ),
                if (permissions >= Permissions.maintainer)
                  if (StateContainer.of(context).organization.creator !=
                      widget.member)
                    MyButton(
                      label: sRemove,
                      onPressed: () {},
                      isExpanded: false,
                      style: MyButtonStyle.floatingError,
                    ),
              ],
            )
          ]),
    );
  }

  void _setIsEditing(bool val) => setState(() => isEditing = val);

  void _onRoleSelected(int? value) {
    if (value == null)
      throw PermissionDeniedError(
          reason: "Must select a role to accept new member");
    setState(() {
      Permissions permission = Permissions.values[value];
      role = Role(permission, anonymous: permission.string);
    });
  }

  void _save() async {
    if (role == null) {
      MyToast.toastError("Member Role not changed");
      return;
    }
    try {
      DefaultChangeMemberRoleInOrganizationUseCase useCase =
          DefaultChangeMemberRoleInOrganizationUseCase(
              FirebaseMemberRepository());
      if (await useCase.execute(
          accessorID: StateContainer.of(context).member.id,
          memberID: widget.member.id,
          role: role!)) {
        MyToast.toastSuccess(
            "Successfully changed ${widget.member.name.fullName} to ${role!.permissions.string}");
        role = null;
      }
    } catch (e) {
      if (kDebugMode) print(e);
      MyToast.toastError(e.toString());
    }
  }
}
