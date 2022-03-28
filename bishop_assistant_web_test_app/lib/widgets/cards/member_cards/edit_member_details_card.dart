import 'package:bishop_assistant_web_test_app/firebase/new_repositories/repositories.dart';
import 'package:bishop_assistant_web_test_app/pages/organization/confirm_member_removal_dialog.dart';
import 'package:bishop_assistant_web_test_app/widgets/widgets.dart';
import 'package:models/models/organization.dart';
import 'package:models/util/extensions/extensions.dart';

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
  Role? role;
  late List<Role> roles;
  late MemberID accessorID;
  late bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    accessorID = StateContainer.of(context).member.id;
    roles = StateContainer.of(context).roles;

    if (StateContainer.of(context).organization.creator == widget.member)
      return Container();

    // TODO Build Custom Expansion Card
    return MyCard(
      child: ExpansionTile(
          trailing: Text(
              isOpen
                  ? role == null
                      ? sCancel
                      : sSave
                  : sEdit,
              style: body),
          onExpansionChanged: (bool status) {
            if (!status && role != null) _save();
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
            widget.member.role.name,
            style: footnoteDark,
          ),
          controlAffinity: ListTileControlAffinity.trailing,
          children: [
            MyDivider(color: darkPrimary),
            MyDropdown(
                hint: sRole,
                onchange: (int? index) {
                  setState(() {
                    role = null;
                    if (index != null) {
                      if (index != 0)
                        role = roles.find(index);
                    }
                  });
                },
                collection: roles
                    .map<DropdownMenuItem<int>>((Role? r) =>
                        DropdownMenuItem(
                            child: Text(r == null ? sRole : r.name,
                                style: body),
                            value: r == null ? 0 : r.id.id.hashCode))
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
      if (role == null) return;
      ChangeMemberRoleInOrganizationUseCase useCase =
          DefaultChangeMemberRoleInOrganizationUseCase(
              FirestoreMemberRepository());
      if (!(await useCase.execute(
          accessorID: accessorID, memberID: widget.member.id, role: role!))) {
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
