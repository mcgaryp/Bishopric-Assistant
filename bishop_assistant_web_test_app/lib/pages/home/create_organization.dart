import 'package:bishop_assistant_web_test_app/repositories/repositories.dart';
import 'package:bishop_assistant_web_test_app/theme/theme.dart';
import 'package:bishop_assistant_web_test_app/util/util.dart';
import 'package:bishop_assistant_web_test_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
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
  final Function fun;
  const CreateOrganization(this.fun, {Key? key}) : super(key: key);

  @override
  _CreateOrganizationState createState() => _CreateOrganizationState();
}

class _CreateOrganizationState extends State<CreateOrganization> {
  final TextEditingController name = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isWaiting = false;

  @override
  Widget build(BuildContext context) {
    return MyCard(children: [
      Form(
          key: _formKey,
          child: Column(
            children: [
              InputField.border(
                sNameOfOrganization,
                controller: name,
                validator: Validators.standard,
                onSubmit: _onSubmit,
              ),
              if (_isWaiting)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: SpinKitCircle(color: dark),
                ),
              AbsorbPointer(
                  absorbing: _isWaiting,
                  child:
                      MyButton(label: sCreate, onPressed: _createOrganization)),
            ],
          )),
    ]);
  }

  void _onSubmit(String? str) => _createOrganization();

  void _createOrganization() async {
    _setIsWaiting(true);
    try {
      DefaultCreateOrganizationUseCase useCase =
          DefaultCreateOrganizationUseCase(FirebaseAccountRepository(),
              FirebaseOrganizationRepository(), FirebaseMemberRepository());
      StateContainerState container = StateContainer.of(context);
      AccountID accountID = StateContainer.of(context).account.id;

      OrganizationMember organizationMember =
          await useCase.execute(creatorId: accountID, name: name.text);

      container.setOrganization(organizationMember);

      MyToast.toastSuccess(
          "Successfully Created ${organizationMember.organization.name}");

      name.clear();

      widget.fun(() {});
    } catch (e) {
      if (kDebugMode) print(e);
      MyToast.toastError(e.toString());
    }
    _setIsWaiting(false);
  }

  _setIsWaiting(bool val) {
    if (mounted) setState(() => _isWaiting = val);
  }
}
