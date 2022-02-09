import 'package:bishop_assistant_web_test_app/pages/organization/confirm_member_removal_dialog.dart';
import 'package:bishop_assistant_web_test_app/repositories/repositories.dart';
import 'package:bishop_assistant_web_test_app/widgets/widgets.dart';
import 'package:models/models/organization.dart';

///
/// edit_member_details_card.dart
/// bishopric-assistant
///
/// Created by Po on 2/1/22
/// Copyright 2022 Po. All rights reserved.
///

class EditMemberDetailsCard extends StatefulWidget {
  final Member member;

  const EditMemberDetailsCard(this.member, {Key? key}) : super(key: key);

  @override
  State<EditMemberDetailsCard> createState() => _EditMemberDetailsCardState();
}

class _EditMemberDetailsCardState extends State<EditMemberDetailsCard> {
  List<Permissions?> get permissions {
    List<Permissions?> lst = [null];
    lst.addAll(Permissions.values);
    return lst;
  }

  Permissions? permission;
  late MemberID accessorID;
  late bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    accessorID = StateContainer.of(context).member.id;

    if (StateContainer.of(context).organization.creator == widget.member)
      return Container();

    // TODO Build Custom Expansion Card
    return MyCard(
      child: ExpansionTile(
          trailing: Text(
              isOpen
                  ? permission == null
                      ? sCancel
                      : sSave
                  : sEdit,
              style: body),
          onExpansionChanged: (bool status) {
            if (!status && permission != null) _save();
            setState(() {
              isOpen = status;
            });
          },
          leading: MemberIcon(Icons.person),
          tilePadding: EdgeInsets.all(0),
          childrenPadding: EdgeInsets.all(0),
          title: Text(
            widget.member.name.fullName,
            style: subhead,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
          subtitle: Text(
            widget.member.role.anonymous,
            style: footnoteDark,
          ),
          controlAffinity: ListTileControlAffinity.trailing,
          children: [
            MyDivider(color: darkPrimary),
            MyDropdown(
                hint: sRole,
                onchange: (int? index) {
                  setState(() {
                    permission = null;
                    if (index != null) {
                      if (index != 0)
                        permission = Permissions.values[index - 1];
                    }
                  });
                },
                collection: permissions
                    .map<DropdownMenuItem<int>>((Permissions? permission) =>
                        DropdownMenuItem(
                            child: Text(
                                permission == null ? sRole : permission.name,
                                style: body),
                            value:
                                permission == null ? 0 : permission.index + 1))
                    .toList()),
            if (StateContainer.of(context).member ==
                StateContainer.of(context).organization.creator)
              MyButton(
                label: sRemove,
                onPressed: _confirmRemove,
                style: MyButtonStyle.errorText,
                isExpanded: false,
              ),
          ]),
    );
  }

  void _save() async {
    try {
      if (permission == null) return;
      ChangeMemberRoleInOrganizationUseCase useCase =
          DefaultChangeMemberRoleInOrganizationUseCase(
              FirebaseMemberRepository());
      Role role = Role(permission!, anonymous: permission!.name);
      if (!(await useCase.execute(
          accessorID: accessorID, memberID: widget.member.id, role: role))) {
        MyToast.toastSuccess("${widget.member.name}'s new role $role");
      }
    } catch (e) {
      if (kDebugMode) print(e);
      MyToast.toastError(e);
    }
  }

  void _confirmRemove() => showDialog(
      context: context,
      builder: (BuildContext context) =>
          ConfirmMemberRemovalDialog(widget.member));
}
