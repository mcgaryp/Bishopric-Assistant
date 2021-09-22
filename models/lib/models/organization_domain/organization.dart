import 'package:models/shared/entity.dart';

///
/// organization.dart
/// bishopric-assistant
///
/// Created by Po on 9/22/21
/// Copyright 2021 Po. All rights reserved.
///

class Organization extends Entity<Organization> {
  Organization(UUID id) : super(id) {}

  @override
  bool sameIdentityAs(Organization other) {
    return this.id == other.id;
  }
}
