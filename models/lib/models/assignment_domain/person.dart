import 'package:models/models/account_domain/contact.dart';
import 'package:models/models/account_domain/name.dart';
import 'package:models/models/organization.dart';
import 'package:models/shared/domain_driven_design/value_object.dart';

///
/// person.dart
/// bishopric-assistant
///
/// Created by Joshua Bee on 1/18/22
/// Copyright 2022 Joshua Bee. All rights reserved.
///

abstract class Person implements ValueObject<Person> {
  final Name name;
  final Contact contact;
  final MemberID id;
  final Authorization authorization;

  Person(
      {required this.name,
      required this.contact,
      required this.id,
      required this.authorization});
}
