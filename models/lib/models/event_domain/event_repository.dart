import 'package:models/models/organization.dart';
import 'package:models/shared/repository.dart';

import '../event.dart';

///
/// event_repository.dart
/// bishopric-assistant
///
/// Created by Po on 9/25/21
/// Copyright 2021 Po. All rights reserved.
///

mixin EventRepository implements Repository<Event, EventID, OrganizationID> {}
