import 'dart:async';

import 'package:bishop_assistant_web_test_app/repositories/firebase_member_repository.dart';
import 'package:bishop_assistant_web_test_app/theme/theme.dart';
import 'package:bishop_assistant_web_test_app/util/util.dart';
import 'package:bishop_assistant_web_test_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:models/models/organization.dart';
import 'package:models/shared/exceptions.dart';

///
/// member_details_card.dart
/// bishop_assistant_web_test_app
///
/// Created by Po on 8/16/21
/// Copyright 2021 Po. All rights reserved.
///

class MemberDetailsCard extends StatefulWidget {
  final Stream<Member> memberStream;

  const MemberDetailsCard(this.memberStream, {Key? key}) : super(key: key);

  @override
  State<MemberDetailsCard> createState() => _MemberDetailsCardState();
}

class _MemberDetailsCardState extends State<MemberDetailsCard> {
  bool isEditing = false;
  Role? role;
  late Member member;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Permissions permissions =
        StateContainer.of(context).member.role.permissions;

    return StreamBuilder(
        stream: widget.memberStream,
        builder: (BuildContext context, AsyncSnapshot<Member> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            member = snapshot.data!;
            return MyCard(
              child: ExpansionTile(
                  maintainState: true,
                  title: MemberTitle(member),
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
                                              child: Text(e.string),
                                              value: e.index))
                                      .toList(),
                                  onchange: _onRoleSelected),
                            ),
                          if (StateContainer.of(context).organization.creator !=
                              StateContainer.of(context).member)
                            Align(
                                alignment: Alignment.centerRight,
                                child: CardButton(
                                    label: isEditing ? sSave : sEdit,
                                    onPressed: () {
                                      if (isEditing == true) {
                                        _save();
                                      }
                                      setIsEditing(!isEditing);
                                    })),
                        ],
                      ),
                    MyDivider(color: darkPrimary),
                    CardRow(sEmail, content: member.contact.email),
                    CardRow(sPhone, content: member.contact.phone),
                    CardRow(sCurrentAssignmentCount, content: "1"),
                    CardRow(sCurrentEventCount, content: "2"),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        CardActionButton(label: sCreateEvent, onPressed: () {}),
                        CardActionButton(
                            label: sCreateAssignment, onPressed: () {}),
                        if (permissions > Permissions.maintainer)
                          CardActionButton(
                              label: sRemove,
                              onPressed: () {},
                              style: MyButtonStyle.error)
                      ],
                    )
                  ]),
            );
          }
          if (snapshot.hasError)
            return Error404(msg: snapshot.error.toString());

          return SpinKitCircle(color: dark);
        });
  }

  void setIsEditing(bool val) => setState(() => isEditing = val);

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
          memberID: member.id,
          role: role!)) {
        MyToast.toastSuccess(
            "Successfully changed ${member.name.fullName} to ${role!.permissions.string}");
        role = null;
      }
    } catch (e) {
      if (kDebugMode) print(e);
      MyToast.toastError(e.toString());
    }
  }
}
