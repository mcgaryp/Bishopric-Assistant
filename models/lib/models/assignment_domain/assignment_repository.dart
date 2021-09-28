import 'package:models/models/assignment.dart';
import 'package:models/models/organization.dart';
import 'package:models/shared/repository.dart';

///
/// assignment_repository.dart
/// bishopric-assistant
///
/// Created by Po on 9/25/21
/// Copyright 2021 Po. All rights reserved.
///

/// TODO: Implement AssignmentRepository, Refer to [ReadMe.md](models/README.md)
mixin AssignmentRepository
    implements Repository<Assignment, AssignmentID, OrganizationID> {}
