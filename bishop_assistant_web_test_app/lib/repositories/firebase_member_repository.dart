import 'package:bishop_assistant_web_test_app/database/firestore_helper.dart';
import 'package:models/models/organization.dart';

///
/// firebase_member_repository.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 12/4/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

class FirebaseMemberRepository extends FirestoreHelper
    implements MemberRepository {
  FirebaseMemberRepository() : super(FirestoreCollectionPath.member);

  @override
  Future<Member?> find(MemberID i) {
    // TODO: implement find
    throw UnimplementedError();
  }

  @override
  Future<List<Member>?> findAll(void o) {
    // TODO: implement findAll
    throw UnimplementedError();
  }

  @override
  Future<Organization?> findOrganization(MemberID memberID) {
    // TODO: implement findOrganization
    throw UnimplementedError();
  }

  @override
  Future<MemberID?> generateNextId() {
    // TODO: implement generateNextId
    throw UnimplementedError();
  }

  @override
  Future<bool> insert(Member m) {
    // TODO: implement insert
    throw UnimplementedError();
  }

  @override
  Future<Result<bool>> remove(MemberID i) {
    // TODO: implement remove
    throw UnimplementedError();
  }

  @override
  Future<bool> update(Member m) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
