import 'package:bishop_assistant_web_test_app/firebase/new_repositories/repositories.dart';
import 'package:bishop_assistant_web_test_app/pages/organization/organization_notification_circle.dart';
import 'package:bishop_assistant_web_test_app/widgets/widgets.dart';
import 'package:models/models/organization.dart';

///
/// organization_requests_view.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 12/9/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

class OrganizationRequestsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirestoreJoinRequestRepository requestRepository =
        FirestoreJoinRequestRepository();

    OrganizationID id = StateContainer.of(context).organization.id;
    Authorization currentUserAuthorization =
        StateContainer.of(context).member.role.authorization;

    List<Authorization> authorizations =
        StateContainer.of(context).authorizations;

    if (currentUserAuthorization >= authorizations.first)
      return StreamBuilder(
          stream: requestRepository.findAllStreamed(id),
          builder: (BuildContext context,
              AsyncSnapshot<List<JoinRequest>> snapshot) {
            if (snapshot.hasData) {
              List<JoinRequest> requests = snapshot.data ?? [];
              return Container(
                height: 55,
                width: 55,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: OrganizationNotificationCircle(requests),
                    ),
                    if (requests.length > 0)
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                            decoration: BoxDecoration(
                                color: errorRed, shape: BoxShape.circle),
                            child: Padding(
                              padding: const EdgeInsets.all(5.5),
                              child:
                                  Text("${requests.length}", style: bodyLight),
                            )),
                      ),
                  ],
                ),
              );
            }

            if (snapshot.hasError && kDebugMode) print(snapshot.error);

            return OrganizationNotificationCircle([]);
          });
    return Container();
  }
}
