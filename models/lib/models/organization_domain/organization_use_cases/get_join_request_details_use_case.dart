import 'package:models/models/account.dart';
import 'package:models/models/organization.dart';
import 'package:models/shared/foundation.dart';

///
/// get_join_request_details_use_case.dart
///
///
/// Created by Porter McGary on 12/8/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

mixin GetJoinRequestDetailsUseCase {
  @required
  Future<JoinRequestDetail> execute(JoinRequest request);
}

class DefaultGetJoinRequestDetailsUseCase
    implements GetJoinRequestDetailsUseCase {
  final AccountRepository _accountRepository;

  DefaultGetJoinRequestDetailsUseCase(this._accountRepository);

  @override
  Future<JoinRequestDetail> execute(JoinRequest request) async {
    Account? account = await _accountRepository.find(request.accountID);
    if (account == null) throw AccountNotFoundError();
    return JoinRequestDetail(name: account.name, request: request);
  }
}
