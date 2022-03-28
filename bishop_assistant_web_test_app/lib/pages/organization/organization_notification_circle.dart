import 'package:bishop_assistant_web_test_app/firebase/new_repositories/repositories.dart';
import 'package:bishop_assistant_web_test_app/pages/organization/join_request_detail_view.dart';
import 'package:bishop_assistant_web_test_app/widgets/widgets.dart';
import 'package:models/models/organization.dart';

///
/// organization_notification_circle.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 2/1/22
/// Copyright 2022 Porter McGary. All rights reserved.
///
class OrganizationNotificationCircle extends StatelessWidget {
  final List<JoinRequest> requests;

  const OrganizationNotificationCircle(this.requests, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: floatingDarkCircleBox,
      height: 40,
      width: 55,
      child: MyButton.icon(
        icon: Icon(
          Icons.notifications,
          color: light,
        ),
        onPressed: () async {
          try {
            List<JoinRequestDetail> details = await _getRequests(requests);
            _showRequests(details, context);
          } catch (e) {
            if (kDebugMode) print(e);
          }
        },
      ),
    );
  }

  void _showRequests(List<JoinRequestDetail> details, BuildContext context) {
    if (details.isNotEmpty)
      showDialog(
          context: context,
          builder: (BuildContext context) => Dialog(
              elevation: 0,
              insetPadding: const EdgeInsets.all(padding8),
              backgroundColor: Colors.transparent,
              child: MyConstrainedBox300(
                child: ListView(
                    children: details
                        .map<JoinRequestDetailsView>(
                            (JoinRequestDetail detail) =>
                                JoinRequestDetailsView(detail))
                        .toList()),
              )));
  }

  Future<List<JoinRequestDetail>> _getRequests(
      List<JoinRequest> requests) async {
    List<JoinRequestDetail> details = [];

    try {
      for (JoinRequest request in requests) {
        DefaultGetJoinRequestDetailsUseCase useCase =
            DefaultGetJoinRequestDetailsUseCase(FirestoreAccountRepository());
        details.add(await useCase.execute(request));
      }
    } catch (e) {
      if (kDebugMode) print(e);
      MyToast.toastError(e);
    }

    return details;
  }
}
