import 'package:models/models/event.dart';

import 'mock_event.dart';

///
/// mock_event_repo.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 2/17/22
/// Copyright 2022 Porter McGary. All rights reserved.
///

class MockEventRepository implements EventRepository {
  bool findFlag = false;
  bool insertFlag = false;
  bool removeFlag = false;
  bool updateFlag = false;

  late final Event event;

  MockEventRepository({Event? event}) : this.event = event ?? MockEvent().event;
}
