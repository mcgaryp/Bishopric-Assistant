import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:models/models/organization.dart';
import 'package:models/models/role.dart';
import 'package:models/models/user.dart';

///
/// role_repository_test.dart
/// bishopric-assistant
///
/// Created by Po on 9/24/21
/// Copyright 2021 Po. All rights reserved.
///

class MockRoleRepository implements RoleRepository {
  static RoleID roleID(int i) => RoleID(i);

  static String name(int i) => "Level $i member";

  static OrganizationID organizationID(int index) => OrganizationID(index);

  static User createUser(int index) =>
      User(firstName: "User", lastName: "$index");

  static String organizationName(int index) => "Organization $index";
  static List<User> users = List.generate(5, (index) => createUser(index));

  final Duration delay = Duration(seconds: 3);
  final List<Role> roles = List.generate(
      5,
      (index) => Role(roleID(index),
          name: name(index),
          securityClearance: SecurityClearance.values[index]));
  final List<Organization> organizations = List.generate(
      5,
      (index) => Organization(
          id: organizationID(index),
          name: organizationName(index),
          creator: users[index]));

  @override
  Future<Role?> find(RoleID roleID) async {
    for (Role member in roles)
      if (member.id == roleID) {
        Future.delayed(delay);
        return member;
      }
  }

  @override
  Future<List<Role>?> findAll(OrganizationID id) async {
    for (Organization organization in organizations) {
      if (organization.id == id) {
        Future.delayed(delay);
        return roles;
      }
    }
  }

  @override
  Future<RoleID> generateNextId() {
    // TODO: implement generateNextId
    throw UnimplementedError();
  }

  @override
  Future<Result> remove(RoleID i) {
    // TODO: implement remove
    throw UnimplementedError();
  }

  @override
  Future<Result> store(Role m) {
    // TODO: implement store
    throw UnimplementedError();
  }

  @override
  Future<Result> update(Role m) {
    // TODO: implement update
    throw UnimplementedError();
  }
}

class RoleRepositoryTest {
  static MockRoleRepository repository = MockRoleRepository();

  static void shouldReturnRole() async {
    // arrange
    RoleID id = RoleID(0);
    // act
    Role? result = await repository.find(id);
    // assert
    expect(result!, repository.roles.first);
  }

  static void shouldReturnNullRole() async {
    // arrange
    RoleID id = RoleID(-1);
    // act
    Role? result = await repository.find(id);
    // assert
    expect(result, null);
  }

  static void shouldReturnAllRoles() async {
    // arrange
    OrganizationID id = OrganizationID(1);
    // act
    List<Role>? results = await repository.findAll(id);
    // assert
    expect(results, repository.roles);
  }

  static void shouldReturnNullInsteadOfRoles() async {
    // arrange
    OrganizationID id = OrganizationID(-1);
    // act
    List<Role>? results = await repository.findAll(id);
    // assert
    expect(results, null);
  }
}

main() {
  test("Role Repository Test", () {
    test("finding a role with and ID", RoleRepositoryTest.shouldReturnRole);
    test("finding a role with a fake ID",
        RoleRepositoryTest.shouldReturnNullRole);
    test("finding all roles in an organization",
        RoleRepositoryTest.shouldReturnAllRoles);
    test("finding all roles with a fake ID",
        RoleRepositoryTest.shouldReturnNullInsteadOfRoles);
  });
}
