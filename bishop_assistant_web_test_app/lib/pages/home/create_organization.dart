import 'package:the_assistant/firebase/repositories/repositories.dart';
import 'package:the_assistant/pages/home/organization_authorization_input.dart';
import 'package:the_assistant/pages/home/organization_roles_input.dart';
import 'package:the_assistant/widgets/widgets.dart';
import 'package:models/models/organization.dart';

///
/// create_organization.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 12/9/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

/// [CreateOrganization] allows the user to create an organization them selves
class CreateOrganization extends StatefulWidget {
  final void Function() onOrganizationCreationCallback;

  const CreateOrganization(this.onOrganizationCreationCallback, {Key? key})
      : super(key: key);

  @override
  _CreateOrganizationState createState() => _CreateOrganizationState();
}

class _CreateOrganizationState extends State<CreateOrganization> {
  static final Authorization _authorization =
      Authorization(name: sUnclassified, rank: 0);
  static final Role _role = Role(authorization: _authorization, name: sOwner);
  final TextEditingController name = TextEditingController();
  List<Authorization> authorizations = [_authorization];

  List<Role?> roles = [_role];

  bool _isWaiting = false;

  String tempRole = "";
  String tempAuth = "";

  @override
  void initState() {
    if (kDebugMode) {
      name.text = "Developers";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MyCard(
        child: Column(children: [
      Form(
          child: Column(
        children: [
          InputField.border(
            sNameOfOrganization,
            controller: name,
            validator: Validators.standard,
            onSubmit: _onSubmit,
          ),
          OrganizationAuthorizationInput(
            authorizations: authorizations,
            onChange: (List<Authorization> auths) {
              setState(() {
                authorizations = auths;
              });
            },
          ),
          OrganizationRolesInput(
              roles: roles,
              authorizations: authorizations,
              onChange: (List<Role?> roles) {
                setState(() {
                  this.roles = roles;
                });
              }),
          if (_isWaiting)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: SpinKitCircle(color: dark),
            ),
          AbsorbPointer(
            absorbing: _isWaiting,
            child: MyButton(label: sCreate, onPressed: _createOrganization),
          ),
        ],
      )),
    ]));
  }

  void _onSubmit(String? str) => _createOrganization();

  void _createOrganization() async {
    _setIsWaiting(true);
    try {
      DefaultCreateOrganizationUseCase useCase =
          DefaultCreateOrganizationUseCase(
        FirestoreAccountRepository(),
        FirestoreOrganizationRepository(),
        FirestoreMemberRepository(),
        FirestoreRoleRepository(),
        FirestoreAuthorizationRepository(),
      );

      List<Role> lst = [];
      for (Role? role in roles) {
        if (role != null) lst.add(role);
      }

      AccountID accountID = StateContainer.of(context).account.id;
      if (await useCase.execute(
        creatorId: accountID,
        name: name.text,
        roles: lst,
        authorizations: authorizations,
        creatorRole: lst.first,
      )) {
        widget.onOrganizationCreationCallback();
        MyToast.toastSuccess("Successfully Created ${name.text}");
      }
    } catch (e) {
      if (kDebugMode) print(e);
      MyToast.toastError(e);
    }
    _setIsWaiting(false);
  }

  _setIsWaiting(bool val) {
    if (mounted) setState(() => _isWaiting = val);
  }
}
