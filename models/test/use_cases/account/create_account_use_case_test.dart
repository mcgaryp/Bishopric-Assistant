import 'package:flutter_test/flutter_test.dart';
import 'package:models/models/account.dart';
import 'package:models/models/account_domain/account_use_cases.dart';
import 'package:models/shared/test.dart';

import '../../mocks/account/mock_account_repository.dart';

///
/// create_account_use_case_test.dart
/// bishopric-assistant
///
/// Created by Po on 10/3/21
/// Copyright 2021 Po. All rights reserved.
///

class CreateAccountUseCaseTest with Test {
  static void
      shouldReturnValidResultWhenValidNameContactCredentialsGiven() async {
    MockAccountRepository accountRepository = MockAccountRepository();
    CreateAccountUseCase accountUseCase =
        DefaultCreateAccountUseCase(accountRepository);
    Account account = accountRepository.accounts.first;
    Name name = account.name;
    Contact contact = account.contact;
    Credentials credentials = account.credentials;
    throw UnimplementedError();
    // Result result = await accountUseCase.execute(
    //     name: name, contact: contact, credentials: credentials);
    // if (result.isError) {
    //   expect(result.isError, true);
    //   expect(result.isValue, false);
    //   expect(result.asValue, null);
    //   expect(result.asError!.error.toString(),
    //       AccountAlreadyExistsError().toString());
    //   return;
    // } else if (result.isValue) {
    //   expect(result.isValue, true);
    //   expect(result.isError, false);
    //   expect(result.asError, null);
    //   expect(result.asValue!.value, account);
    //   return;
    // }
    // Test.fallthrough;
  }

  static void
      shouldReturnAccountAlreadyExistsErrorWhenInvalidCredentialsGiven() async {
    MockAccountRepository accountRepository = MockAccountRepository();
    CreateAccountUseCase accountUseCase =
        DefaultCreateAccountUseCase(accountRepository);
    Account account = accountRepository.accounts.first;
    Name name = account.name;
    Contact contact = account.contact;
    Credentials credentials = account.credentials;
    throw UnimplementedError();
    // Result result = await accountUseCase.execute(
    //     name: name, contact: contact, credentials: credentials);
    //
    // expect(result.isError, true);
    // expect(result.isValue, false);
    // expect(result.asValue, null);
    //
    // if (result.asError!.error.runtimeType == FailedToSaveError)
    //   expect(result.asError!.error.toString(),
    //       FailedToSaveError(forEntity: "Account").toString());
    //
    // if (result.asError!.error.runtimeType == AccountAlreadyExistsError)
    //   expect(result.asError!.error.toString(),
    //       AccountAlreadyExistsError().toString());
  }
}

runCreateAccountUseCaseTests() {
  group("Create Account Use Case", () {
    test(
        "should return Request type ok when given valid account",
        CreateAccountUseCaseTest
            .shouldReturnValidResultWhenValidNameContactCredentialsGiven);

    test(
        "should return Account already exists error when account username is already in use",
        CreateAccountUseCaseTest
            .shouldReturnAccountAlreadyExistsErrorWhenInvalidCredentialsGiven);
  });
}
