import 'package:async/async.dart';
import 'package:flutter/foundation.dart';
import 'package:models/models/organization.dart';
import 'package:models/models/user.dart';

///
/// create_organization.dart
/// bishopric-assistant
///
/// Created by Po on 9/23/21
/// Copyright 2021 Po. All rights reserved.
///

mixin CreateOrganizationUseCase {
  /// Creates a new organization
  ///
  /// [creatorId] id of the creator of the organization
  /// [name] given to the new organization
  /// returns a [ResultValue] if successful else [ResultError]
  @required
  Future<Result> execute({required UserID creatorId, required String name});
}

class DefaultCreateOrganizationUseCase implements CreateOrganizationUseCase {
  final UserRepository _userRepository;
  final OrganizationRepository _organizationRepository;

  DefaultCreateOrganizationUseCase(
      this._userRepository, this._organizationRepository);

  @override
  Future<Result> execute(
      {required UserID creatorId, required String name}) async {
    User creator = await _userRepository.find(creatorId);
    OrganizationID id = await _organizationRepository.generateNextId();
    Organization organization =
        Organization(id: id, creator: creator, name: name);
    Result result = await _organizationRepository.store(organization);

    return result;
  }
}
