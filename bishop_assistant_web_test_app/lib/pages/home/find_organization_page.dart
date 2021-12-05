import 'package:bishop_assistant_web_test_app/database/firestore_helper.dart';
import 'package:bishop_assistant_web_test_app/repositories/firebase_account_repository.dart';
import 'package:bishop_assistant_web_test_app/repositories/firebase_member_repository.dart';
import 'package:bishop_assistant_web_test_app/repositories/firebase_organization_repository.dart';
import 'package:bishop_assistant_web_test_app/state/state_container.dart';
import 'package:bishop_assistant_web_test_app/theme/Colors.dart';
import 'package:bishop_assistant_web_test_app/util/util.dart';
import 'package:bishop_assistant_web_test_app/widgets/cards/card_support/MyCard.dart';
import 'package:bishop_assistant_web_test_app/widgets/cards/organization_cards/organization_card.dart';
import 'package:bishop_assistant_web_test_app/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:models/models/account.dart';
import 'package:models/models/organization.dart';
import 'package:models/models/organization_domain/organization_use_case.dart';
import 'package:responsive_builder/responsive_builder.dart';

///
/// find_organization_page.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 11/5/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

class FindOrganizationPage extends Mobile {
  @override
  Widget build(BuildContext context) {
    // TODO: Improve Stream by removing future builder below it
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(FirestoreCollectionPath.organizations.string)
            .snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return FutureBuilder(
                future: _getOrganizations(context),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Organization>?> snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    List<Organization> organizations = snapshot.data!;
                    return ScreenTypeLayout(
                        mobile: LightPage.mobileAction(
                            ListOfOrganizations.mobile(organizations), ""),
                        desktop: LightPage.web([
                          ListOfOrganizations.web(organizations),
                          CreateOrganization()
                        ]));
                  }

                  if (snapshot.hasError)
                    return Error404Page(msg: snapshot.error.toString());

                  return SpinKitCircle(color: dark);
                });
          }

          if (snapshot.hasError)
            return Error404Page(msg: snapshot.error.toString());

          return SpinKitCircle(color: dark);
        });
  }

  Future<List<Organization>?> _getOrganizations(BuildContext context) async {
    try {
      DefaultAllOrganizationsUseCase useCase =
          DefaultAllOrganizationsUseCase(FirebaseOrganizationRepository());
      Result<List<Organization>> result = await useCase.execute();
      if (result.isError) throw result.asError!.error;
      if (result.isValue) return result.asValue!.value;
    } catch (e) {
      MyToast.toastError(e.toString());
      if (kDebugMode) print(e);
      throw e;
    }
  }
}

class ListOfOrganizations extends Mobile {
  final List<Organization> organizations;
  late final bool isWeb;

  ListOfOrganizations.mobile(this.organizations) {
    isWeb = false;
  }

  ListOfOrganizations.web(this.organizations) {
    isWeb = true;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    organizations.forEach(
        (element) => children.add(OrganizationCard(organization: element)));
    if (isWeb)
      return WebContentSnapShot(title: organizationsStr, children: children);
    return MobileContentSnapShot([Section(organizationsStr, children)]);
  }
}

class CreateOrganization extends Mobile {
  @override
  Widget build(BuildContext context) {
    return WebContentSnapShot(
        title: createOrganization, children: [_CreateOrganization()]);
  }
}

class _CreateOrganization extends StatefulWidget {
  const _CreateOrganization({Key? key}) : super(key: key);

  @override
  _CreateOrganizationState createState() => _CreateOrganizationState();
}

class _CreateOrganizationState extends State<_CreateOrganization> {
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
                nameOfOrganization,
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
                      MyButton(label: create, onPressed: _createOrganization)),
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

      AccountID accountID = StateContainer.of(context).account.id;

      Result<Organization> result =
          await useCase.execute(creatorId: accountID, name: name.text);
      if (result.isError) throw result.asError!.error;
      if (result.isValue) {
        MyToast.toastSuccess(
            "Successfully Created ${result.asValue!.value.name}");
        name.clear();
      }
    } catch (e) {
      if (kDebugMode) print(e);
      MyToast.toastError(e.toString());
    }
    _setIsWaiting(false);
  }

  _setIsWaiting(bool val) => setState(() => _isWaiting = val);
}
