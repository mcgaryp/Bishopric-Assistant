///
/// organization_already_exists_error.dart
/// bishopric-assistant
///
/// Created by Po on 10/02/21
/// Copyright 2021 Po. All rights reserved.
///

class OrganizationAlreadyExistsError implements Exception {
  final String msg = "Organization already exists";

  @override
  String toString() {
    return msg;
  }
}
