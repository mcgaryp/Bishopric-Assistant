import 'package:bishop_assistant_web_test_app/database/FirestoreDocument.dart';

///
/// MemberEvents.dart
/// bishop_assistant_web_test_app
///
/// Created by Po on 8/22/21
/// Copyright 2021 Po. All rights reserved.
///
@Deprecated("")
class MemberEvents extends Document {
  static const String memberId = "member_id";
  static const String organizationEventId = "organization_event_id";

  MemberEvents(int memberID, int organizationEventID)
      : super({memberId: memberID, organizationEventId: organizationEventID});
}
