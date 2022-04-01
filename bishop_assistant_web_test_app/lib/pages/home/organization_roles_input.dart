import 'package:bishop_assistant_web_test_app/widgets/widgets.dart';
import 'package:models/models/organization.dart';

///
/// $FILE_NAME.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 3/20/22
/// Copyright 2022 Porter McGary. All rights reserved.
///

class OrganizationRolesInput extends StatefulWidget {
  final List<Authorization> authorizations;
  final void Function(List<Role?>)? onChange;
  final List<Role?> roles;

  const OrganizationRolesInput(
      {Key? key,
      this.authorizations = const [],
      this.onChange,
      required this.roles})
      : super(key: key);

  @override
  State<OrganizationRolesInput> createState() => _OrganizationRolesInputState();
}

class _OrganizationRolesInputState extends State<OrganizationRolesInput> {
  double height = 75;
  List<InputField> inputs = [];
  List<TextEditingController> controllers = [];
  List<Role?> roles = [];
  List<int?> ranks = [];

  @override
  void initState() {
    roles = widget.roles;

    for (Role? role in roles) {
      // add to controllers
      controllers.add(TextEditingController.fromValue(
          TextEditingValue(text: role?.name ?? sOwner)));

      // add to inputs
      inputs.add(InputField.plain(
        role?.name ?? sOwner,
        label: sRoleName,
        controller: controllers.last,
        onChange: (String? str) {
          _updateRoles();
          return str;
        },
      ));

      // ranks
      ranks.add(null);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(sRoles, style: subhead),
          IconButton(onPressed: _add, icon: Icon(Icons.add)),
        ],
      ),
      SizedBox(
        height: height,
        child: ListView.builder(
            itemCount: inputs.length,
            itemBuilder: (BuildContext listContext, int index) {
              return LayoutBuilder(builder:
                  (BuildContext layoutContext, BoxConstraints constraints) {
                InputField input = inputs[index];
                return Dismissible(
                  key: ValueKey<InputField>(input),
                  confirmDismiss: (DismissDirection direction) async {
                    if (index != 0 || inputs.length > 1) {
                      return _confirmDismiss(direction, listContext, input);
                    }
                    return false;
                  },
                  onDismissed: (DismissDirection direction) =>
                      _onDismiss(direction, index),
                  background: DeleteListTileBackground(),
                  child: ListTile(
                    leading: SizedBox(
                        width: constraints.widthConstraints().maxWidth / 3,
                        child: input),
                    title: MyDropdown(
                      onchange: (int? rank) {
                        ranks[index] = rank;
                        _updateRoles();
                      },
                      hint: sGroup,
                      collection: widget.authorizations
                          .map<DropdownMenuItem<int>>(
                              (Authorization authorization) => DropdownMenuItem(
                                    child:
                                        Text(authorization.name, style: body),
                                    value: authorization.rank,
                                  ))
                          .toList(),
                    ),
                  ),
                );
              });
            }),
      ),
    ]);
  }

  void _add() {
    setState(() {
      roles.add(null);
      ranks.add(null);
      controllers.add(TextEditingController());
      inputs.add(InputField.plain(
        sNewRole,
        label: sRoleName,
        controller: controllers.last,
        onChange: (String? str) {
          _updateRoles();
          return str;
        },
      ));
      _updateHeight();
    });
  }

  void _remove(int index) {
    inputs.removeAt(index);
    controllers.removeAt(index);
    roles.removeAt(index);
    _updateRoles();
    _updateHeight();
  }

  void _updateHeight() => height = inputs.length * 75;

  void _updateRoles() {
    roles = [];

    for (int index = 0; index < inputs.length; index++) {
      Role role = Role(
          name: controllers[index].text,
          authorization: widget.authorizations
              .firstWhere((Authorization auth) => auth.rank == ranks[index]));
      roles.add(role);
    }

    if (widget.onChange != null) widget.onChange!(roles);
  }

  Future<bool> _confirmDismiss(DismissDirection direction, BuildContext context,
      InputField input) async {
    if (direction == DismissDirection.endToStart) {
      bool dismiss = false;
      await showDialog(
          context: context,
          builder: (BuildContext dialogContext) {
            return ConfirmationDialog(
                onConfirm: () {
                  dismiss = true;
                  Navigator.pop(dialogContext);
                },
                title: sConfirmDelete,
                content: "Are you sure you would like "
                    "to remove `${input.controller?.text}`?");
          });
      return dismiss;
    }
    return false;
  }

  void _onDismiss(DismissDirection direction, int index) {
    if (direction == DismissDirection.endToStart) {
      setState(() {
        _remove(index);
      });
    }
  }
}
