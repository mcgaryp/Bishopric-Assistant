import 'package:the_assistant/firebase/repositories/repositories.dart';
import 'package:the_assistant/widgets/widgets.dart';
import 'package:models/models/account.dart';
import 'package:models/models/organization.dart';

///
/// organization_card.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 11/5/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

class OrganizationCard extends StatelessWidget {
  final Organization organization;

  const OrganizationCard({Key? key, required this.organization})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyCard(
        child: Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: padding8),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              CardTitle(organization.name),
              Text(organization.creator.name.fullName, style: captionDark),
            ]),
          ),
          StreamBuilder<List<JoinRequest>>(
              stream: FirestoreJoinRequestRepository()
                  .findAllStreamed(organization.id),
              builder: (BuildContext context, snapshot) {
                if (snapshot.hasData) {
                  List<JoinRequest> requests = snapshot.data ?? [];
                  for (JoinRequest request in requests) {
                    if (request.accountID ==
                        StateContainer.of(context).account.id)
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(sAwaiting, style: body),
                      );
                  }
                  return MyButton(
                    label: sJoin,
                    onPressed: () => _joinOrganization(context),
                    style: MyButtonStyle.text,
                    isExpanded: false,
                  );
                }
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SpinKitThreeBounce(color: dark, size: 25),
                );
              }),
        ],
      ),
    ]));
  }

  void _joinOrganization(BuildContext context) async {
    try {
      Account account = StateContainer.of(context).account;
      DefaultJoinOrganizationUseCase useCase =
          DefaultJoinOrganizationUseCase(FirestoreJoinRequestRepository());
      if (await useCase.execute(
          accountID: account.id, organizationID: organization.id))
        MyToast.toastSuccess(
            "${account.name.fullName}'s request to join ${organization.name} has been sent");
      else
        MyToast.toastError("Failed to send request");
    } catch (e) {
      if (kDebugMode) print(e);
      MyToast.toastError(e);
    }
  }
}
