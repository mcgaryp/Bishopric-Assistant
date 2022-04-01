import 'package:the_assistant/widgets/widgets.dart';
import 'package:models/models/organization.dart';

///
/// $FILE_NAME.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 3/20/22
/// Copyright 2022 Porter McGary. All rights reserved.
///

class OrganizationAuthorizationInput extends StatefulWidget {
  final List<Authorization> authorizations;
  final void Function(List<Authorization>)? onChange;

  const OrganizationAuthorizationInput(
      {Key? key, this.onChange, required this.authorizations})
      : super(key: key);

  @override
  State<OrganizationAuthorizationInput> createState() =>
      _OrganizationAuthorizationInputState();
}

class _OrganizationAuthorizationInputState
    extends State<OrganizationAuthorizationInput> {
  double height = 60;
  List<InputField> inputs = [];
  List<TextEditingController> controllers = [];
  List<Authorization> _authorizations = [];
  late void Function(List<Authorization>) onChange;

  @override
  void initState() {
    // Set on change
    if (widget.onChange != null) {
      onChange = widget.onChange!;
    } else {
      onChange = (List<Authorization> auths) {};
    }

    // Set authorizations list
    _authorizations = widget.authorizations;

    for (Authorization authorization in _authorizations) {
      // Set up Text Controllers
      TextEditingController controller =
          TextEditingController(text: authorization.name);
      controllers.add(controller);

      // Set up Input Fields
      InputField inputField = InputField.plain(
        authorization.name,
        label: sGroupName,
        controller: controller,
        onChange: (String? str) {
          _updateAuthorizations();
          return str;
        },
      );
      inputs.add(inputField);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        // Authorization Level Text
        Text(sGroups, style: subhead),
        // Plus Button
        IconButton(onPressed: _add, icon: Icon(Icons.add))
      ]),
      // List of Changeable Names
      SizedBox(
          height: height,
          child: ListView.builder(
            itemCount: inputs.length,
            itemBuilder: (BuildContext listContext, int index) {
              InputField input = inputs[index];
              return Dismissible(
                key: ValueKey<InputField>(input),
                confirmDismiss: (DismissDirection direction) async {
                  if (index != 0 || inputs.length > 1)
                    return _confirmDismiss(direction, listContext, input);
                  return false;
                },
                onDismissed: (DismissDirection direction) =>
                    _onDismiss(direction, index),
                background: DeleteListTileBackground(),
                child: ListTile(
                  leading: Text("${inputs.length - index - 1}", style: body),
                  title: input,
                ),
              );
            },
          )),
    ]);
  }

  void _add() {
    setState(() {
      controllers.add(TextEditingController());
      inputs.add(InputField.plain(sAuthorization,
          label: sGroupName,
          controller: controllers.last, onChange: (String? str) {
        _updateAuthorizations();
        return str;
      }));
      _updateHeight();
      _updateAuthorizations();
    });
  }

  void _updateAuthorizations() {
    _authorizations = [];
    for (int i = 0; i < controllers.length; i++) {
      _authorizations.add(Authorization(
          name: controllers[i].text, rank: controllers.length - i - 1));
    }
    onChange(_authorizations);
  }

  void _updateHeight() => height = inputs.length * 60;

  Future<bool> _confirmDismiss(DismissDirection direction, BuildContext context,
      InputField input) async {
    // Ask to confirm dismiss...
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
        inputs.removeAt(index);
        controllers.removeAt(index);
        _updateHeight();
        _updateAuthorizations();
      });
    }
  }
}
