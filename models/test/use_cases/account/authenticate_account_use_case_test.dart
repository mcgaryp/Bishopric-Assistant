import 'package:flutter_test/flutter_test.dart';
import 'package:models/models/account.dart';
import 'package:models/models/account_domain/account_use_cases.dart';
import 'package:models/shared/test.dart';

import '../../mocks/account/mock_account_repository.dart';
import '../../mocks/account/mock_credentials.dart';

///
/// authenticate_account_use_case_test.dart
/// bishopric-assistant
///
/// Created by Po on 10/3/21
/// Copyright 2021 Po. All rights reserved.
///

class AuthenticateAccountUseCaseTest with Test {
  static void shouldReturnValidResultWhenValidCredentials() async {
    MockAccountRepository accountRepository = MockAccountRepository();
    DefaultAuthenticateAccountUseCase authenticateAccount =
        DefaultAuthenticateAccountUseCase(accountRepository);
    Account account = accountRepository.accounts.first;
    Credentials credentials = account.credentials;
    throw UnimplementedError();
    // Result<Account> result = await authenticateAccount.execute(credentials);
    // expect(result.isError, false);
    // expect(result.isValue, true);
    // expect(result.asError, null);
    // Account? value = result.asValue?.value;
    // if (value == null) Test.fallthrough;
    // expect(value, account);
  }

  static void shouldReturnInvalidResultWhenInValidUsername() async {
    MockAccountRepository accountRepository = MockAccountRepository();
    DefaultAuthenticateAccountUseCase authenticateAccount =
        DefaultAuthenticateAccountUseCase(accountRepository);
    Account account = accountRepository.accounts.first;
    Credentials credentials = MockCredentials(username: "bobby").credentials;
    throw UnimplementedError();
    // Result<Account> result = await authenticateAccount.execute(credentials);
    // expect(result.isError, true);
    // expect(result.isValue, false);
    // expect(result.asValue, null);
    // Exception? value = result.asError?.error as Exception?;
    // if (value == null) Test.fallthrough;
    // expect(
    //     value.toString(),
    //     PermissionDeniedError(reason: "Incorrect Username or Password")
    //         .toString());
  }

  static void shouldReturnInvalidResultWhenInValidPassword() async {
    MockAccountRepository accountRepository = MockAccountRepository();
    DefaultAuthenticateAccountUseCase authenticateAccount =
        DefaultAuthenticateAccountUseCase(accountRepository);
    Account account = accountRepository.accounts.first;
    Credentials credentials = MockCredentials(password: "bobby").credentials;
    throw UnimplementedError();
    // Result<Account> result = await authenticateAccount.execute(credentials);
    // expect(result.isError, true);
    // expect(result.isValue, false);
    // expect(result.asValue, null);
    // Exception? value = result.asError?.error as Exception?;
    // if (value == null) Test.fallthrough;
    // expect(
    //     value.toString(),
    //     PermissionDeniedError(reason: "Incorrect Username or Password")
    //         .toString());
  }
}

runAuthenticateAccountTests() {
  group("Account Authentication", () {
    test(
        "should return an account",
        AuthenticateAccountUseCaseTest
            .shouldReturnValidResultWhenValidCredentials);
    test(
        "should return an incorrect username error",
        AuthenticateAccountUseCaseTest
            .shouldReturnInvalidResultWhenInValidUsername);
    test(
        "should return an incorrect password error",
        AuthenticateAccountUseCaseTest
            .shouldReturnInvalidResultWhenInValidPassword);
  });
}
