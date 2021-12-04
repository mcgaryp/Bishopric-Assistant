import 'package:bishop_assistant_web_test_app/database/firestore_helper.dart';
import 'package:models/models/organization.dart';

///
/// firebase_organization_repository.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 12/4/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

class FirebaseOrganizationRepository extends FirestoreHelper
    implements OrganizationRepository {
  FirebaseOrganizationRepository()
      : super(FirestoreCollectionPath.organization);

  @override
  Future<bool> addMember(Member member) {
    // TODO: implement addMember
    throw UnimplementedError();
  }

  @override
  Future<Organization?> find(OrganizationID i) {
    // TODO: implement find
    throw UnimplementedError();
  }

  @override
  Future<List<Organization>?> findAll(void o) {
    // TODO: implement findAll
    throw UnimplementedError();
  }

  @override
  Future<OrganizationID?> generateNextId() {
    // TODO: implement generateNextId
    throw UnimplementedError();
  }

  @override
  Future<bool> insert(Organization m) {
    // TODO: implement insert
    throw UnimplementedError();
  }

  @override
  Future<Result<bool>> remove(OrganizationID i) {
    // TODO: implement remove
    throw UnimplementedError();
  }

  @override
  Future<bool> update(Organization m) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
