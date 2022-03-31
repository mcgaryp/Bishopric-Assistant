import 'package:flutter_test/flutter_test.dart';

import 'account_domain/account_test.dart';
import 'account_domain/contact_test.dart';
import 'account_domain/credentials_test.dart';
import 'account_domain/name_test.dart';
import 'account_domain/pin_test.dart';
import 'account_domain/use_cases/authenticate_account_use_case_test.dart';
import 'account_domain/use_cases/change_contact_use_case_test.dart';
import 'account_domain/use_cases/change_password_use_case_test.dart';
import 'account_domain/use_cases/confirm_pin_use_case_test.dart';
import 'account_domain/use_cases/create_account_use_case_test.dart';
import 'account_domain/use_cases/deactivate_account_use_case_test.dart';
import 'account_domain/use_cases/get_state_use_case_tests.dart';
import 'account_domain/use_cases/logout_account_use_case_tests.dart';
import 'account_domain/use_cases/reactivate_account_use_case_tests.dart';
import 'account_domain/use_cases/save_state_use_case_tests.dart';
import 'account_domain/user_state_test.dart';
import 'assignment_domain/assignment_test.dart';
import 'assignment_domain/use_cases/archive_assignment_use_case_test.dart';
import 'assignment_domain/use_cases/create_assignment_use_case_test.dart';
import 'assignment_domain/use_cases/delete_assignment_use_case_tests.dart';
import 'assignment_domain/use_cases/find_all_archived_assignments_use_case_test.dart';
import 'assignment_domain/use_cases/find_all_assignments_use_case_test.dart';
import 'assignment_domain/use_cases/mark_assignment_complete_use_case_test.dart';
import 'assignment_domain/use_cases/mark_assignment_incomplete_use_case_test.dart';
import 'assignment_domain/use_cases/unarchive_assignment_use_case_test.dart';
import 'assignment_domain/use_cases/update_assignment_use_case_test.dart';
import 'organization_domain/member_test.dart';
import 'organization_domain/organization_test.dart';
import 'organization_domain/role_test.dart';
import 'organization_domain/use_cases/add_member_to_organization_use_case_test.dart';
import 'organization_domain/use_cases/change_member_role_in_organization_use_case_test.dart';
import 'organization_domain/use_cases/change_organization_name_use_case_test.dart';
import 'organization_domain/use_cases/create_organization_use_case_test.dart';
import 'organization_domain/use_cases/delete_organization_use_case_test.dart';
import 'organization_domain/use_cases/get_join_request_details_use_case_test.dart';
import 'organization_domain/use_cases/has_associated_organization_use_case_test.dart';
import 'organization_domain/use_cases/join_organization_use_case_test.dart';
import 'organization_domain/use_cases/reject_request_use_case_test.dart';
import 'organization_domain/use_cases/remove_member_from_organization_use_case_test.dart';

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
      group("Account Use Case Tests", () {
        runAuthenticateAccountTests();
        runChangeContactTests();
        runChangePasswordUseCaseTests();
        runConfirmPinUseCaseTests();
        runCreateAccountUseCaseTests();
        runDeactivateAccountUseCaseTests();
        runGetStateUseCaseTests();
        runLogoutAccountUseCaseTests();
        runReactivateAccountUseCaseTests();
        runSaveStateUseCaseTests();
      });
      runAccountTests();
      runContactTests();
      runCredentialsTests();
      runNameTests();
      runPinTests();
      runUserStateTests();
    });
    group("Assignment Tests", () {
      group("Assignment Use Case Tests", () {
        runArchiveAssignmentUseCaseTest();
        runCreateAssignmentUseCaseTest();
        runDeleteAssignmentUseCaseTests();
        runFindAllArchivedAssignmentsUseCaseTests();
        runFindAllAssignmentsUseCaseTest();
        runMarkAssignmentCompleteUseCaseTest();
        runMarkAssignmentIncompleteUseCaseTest();
        runUnarchiveAssignmentUseCaseTest();
        runUpdateAssignmentUseCaseTest();
      });
      runAssignmentTests();
    });
    group("Event Tests", () {});
    group("Organization Tests", () {
      group("Use Case Tests", () {
        runAddMemberToOrganizationUseCaseTest();
        runChangeMemberRoleInOrganizationUseCaseTest();
        runChangeOrganizationNameUseCaseTest();
        runCreateOrganizationUseCaseTest();
        runDeleteOrganizationUseCaseTest();
        runGetJoinRequestDetailsUseCaseTest();
        runHasAssociatedOrganizationUseCaseTest();
        runJoinOrganizationUseCaseTest();
        runRejectRequestUseCaseTest();
        runRemoveMemberFromOrganizationUseCaseTest();
      });
      group("Member Tests", () {
        runMemberTests();
      });
      runOrganizationTests();
      runRoleTests();
    });
  });
}
