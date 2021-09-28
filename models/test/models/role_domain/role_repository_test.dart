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

/// TODO: Make the repo a use case repo
class MockRoleRepository implements RoleRepository {
  static RoleID roleID(String i) => RoleID(i);

  static String name(int i) => "Level $i member";

  static OrganizationID organizationID(String index) => OrganizationID(index);

  static User createUser(int index) => User.generic(
      id: UserID(index.toString()),
      firstName: "User",
      lastName: "$index",
      username: "",
      password: "");

  static String organizationName(int index) => "Organization $index";
  static List<User> users = List.generate(5, (index) => createUser(index));

  final Duration delay = Duration(seconds: 3);
  final List<Role> roles = List.generate(
      5,
      (index) => Role(
          id: RoleID(index.toString()),
          name: name(index),
          securityClearance: SecurityClearance.values[index]));
  final List<Organization> organizations = List.generate(
      5,
      (index) => Organization(
          id: organizationID(index.toString()),
          name: organizationName(index),
          creator: users[index]));

  @override
  Future<Role?> find(RoleID roleID) async {
    for (Role member in roles)
      if (member == roleID) {
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

  // TODO: Add Should_Expected_When_StateUnderTest as function names
  static void shouldReturnRoleWhenValidID() async {
    // arrange
    RoleID id = RoleID("0");
    // act
    Role? result = await repository.find(id);
    // assert
    expect(result!, repository.roles.first);
  }

  static void shouldReturnNullRoleWhenInValidID() async {
    // arrange
    RoleID id = RoleID("");
    // act
    Role? result = await repository.find(id);
    // assert
    expect(result, null);
  }

  static void shouldReturnAllRolesWhenValidOrganizationID() async {
    // arrange
    OrganizationID id = OrganizationID("1");
    // act
    List<Role>? results = await repository.findAll(id);
    // assert
    expect(results, repository.roles);
  }

  static void shouldReturnNullWhenInvalidOrganizationID() async {
    // arrange
    OrganizationID id = OrganizationID("");
    // act
    List<Role>? results = await repository.findAll(id);
    // assert
    expect(results, null);
  }
}

main() {
  group("Role Repository Test", () {
    test("finding a role with and ID",
        RoleRepositoryTest.shouldReturnRoleWhenValidID);
    test("finding a role with a fake ID",
        RoleRepositoryTest.shouldReturnNullRoleWhenInValidID);
    test("finding all roles in an organization",
        RoleRepositoryTest.shouldReturnAllRolesWhenValidOrganizationID);
    test("finding all roles with a fake ID",
        RoleRepositoryTest.shouldReturnNullWhenInvalidOrganizationID);
  });
}
