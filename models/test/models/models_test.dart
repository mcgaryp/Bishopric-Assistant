import 'package:flutter_test/flutter_test.dart';

import 'account_domain/account_id_test.dart';
import 'account_domain/account_test.dart';
import 'account_domain/contact_test.dart';
import 'account_domain/credentials_test.dart';
import 'account_domain/name_test.dart';
import 'account_domain/pin_test.dart';
import 'organization_domain/member_id_test.dart';
import 'organization_domain/member_test.dart';
import 'organization_domain/organization_id_test.dart';
import 'organization_domain/organization_test.dart';
import 'organization_domain/permissions_extension_test.dart';
import 'organization_domain/role_test.dart';

///
/// models_test.dart
/// bishopric-assistant
///
/// Created by Po on 9/27/21
/// Copyright 2021 porter. All rights reserved.
///

runModelsTests() {
  group("Models Tests", () {
    group("Account Tests", () {
      runAccountIDTests();
      runAccountTests();
      runContactTests();
      runCredentialsTests();
      runNameTests();
      runPinTests();
    });
    group("Assignment Tests", () {});
    group("Event Tests", () {});
    group("Member Tests", () {
      runMemberIDTests();
      runMemberTests();
    });
    group("Organization Tests", () {
      runOrganizationIDTests();
      runOrganizationTests();
      runPermissionTests();
      runRoleTests();
    });
  });
}
