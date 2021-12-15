import 'package:bishop_assistant_web_test_app/pages/organization/join_request_detail_view.dart';
import 'package:bishop_assistant_web_test_app/repositories/repositories.dart';
import 'package:bishop_assistant_web_test_app/theme/theme.dart';
import 'package:bishop_assistant_web_test_app/util/util.dart';
import 'package:bishop_assistant_web_test_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:models/models/organization.dart';

///
/// organization_requests_view.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 12/9/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

class OrganizationRequestsView extends StatelessWidget {
  const OrganizationRequestsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DefaultAllOrganizationRequestsUseCase useCase =
        DefaultAllOrganizationRequestsUseCase(FirebaseOrganizationRepository());
    OrganizationID id;

    try {
      id = StateContainer.of(context).organization.id;
    } catch (e) {
      return Error404(msg: e.toString());
    }

    return StreamBuilder(
        stream: useCase.execute(id),
        builder:
            (BuildContext context, AsyncSnapshot<List<JoinRequest>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null) {
              List<JoinRequest> requests = snapshot.data!;
              return FutureBuilder(
                  future: _getRequests(requests),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<JoinRequestDetail>> snapshot) {
                    if (snapshot.hasData) {
                      List<JoinRequestDetail> details = snapshot.data!;
                      return MyConstrainedBox200(
                        child: MyButton(
                          label: "Join Requests ${requests.length}",
                          onPressed: () => _showRequests(details, context),
                          style: MyButtonStyle.standard,
                        ),
                      );
                    }

                    if (snapshot.hasError) {
                      if (kDebugMode) print(snapshot.error);
                      return Error404(msg: snapshot.error.toString());
                    }

                    return Container();
                  });
            }
            return Container();
          }

          if (snapshot.hasError) {
            if (kDebugMode) print(snapshot.error);
            return Error404(msg: snapshot.error.toString());
          }

          return Container();
        });
  }

  Future<List<JoinRequestDetail>> _getRequests(
      List<JoinRequest> requests) async {
    List<JoinRequestDetail> details = [];

    try {
      for (JoinRequest request in requests) {
        DefaultGetJoinRequestDetailsUseCase useCase =
            DefaultGetJoinRequestDetailsUseCase(FirebaseAccountRepository());
        details.add(await useCase.execute(request));
      }
    } catch (e) {
      if (kDebugMode) print(e);
      MyToast.toastError(e.toString());
    }

    return details;
  }

  void _showRequests(List<JoinRequestDetail> details, BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) => Dialog(
            insetPadding: const EdgeInsets.all(padding8),
            backgroundColor: Colors.transparent,
            child: MyConstrainedBox300(
              child: ListView(
                  children: details
                      .map<JoinRequestDetailsView>((JoinRequestDetail detail) =>
                          JoinRequestDetailsView(detail))
                      .toList()),
            )));
  }
}
