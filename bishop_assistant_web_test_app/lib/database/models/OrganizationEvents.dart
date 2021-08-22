import 'package:bishop_assistant_web_test_app/database/FirestoreDocument.dart';

///
/// OrganizationEvents.dart
/// bishop_assistant_web_test_app
///
/// Created by Po on 8/22/21
/// Copyright 2021 Po. All rights reserved.
///

class OrganizationEvents extends Document {
  static const String eventId = "event_id";
  static const String organizationId = "organization_id";

  OrganizationEvents(int eventID, int organizationID)
      : super({eventId: eventID, organizationId: organizationID});
}
