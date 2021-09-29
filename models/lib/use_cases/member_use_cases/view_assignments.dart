import 'package:models/shared/foundation.dart';

///
/// view_assignments.dart
/// bishopric-assistant
///
/// Created by Po on 9/29/21
/// Copyright 2021 Po. All rights reserved.
///

mixin ViewAssignmentsUseCase {
  @required
  Future<Result> execute();
}

class DefaultViewAssignments implements ViewAssignmentsUseCase {
  @override
  Future<Result> execute() {
    // TODO: implement
    throw UnimplementedError();
  }
}
