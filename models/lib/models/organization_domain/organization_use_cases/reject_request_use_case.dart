import 'package:models/models/organization.dart';

///
/// reject_request_use_case.dart
///
///
/// Created by Porter McGary on 12/9/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

mixin RejectRequestUseCase {
  @required
  Future<bool> execute(JoinRequestID id);
}

class DefaultRejectRequestUseCase implements RejectRequestUseCase {
  final JoinRequestRepository _requestRepository;

  DefaultRejectRequestUseCase(this._requestRepository);

  @override
  Future<bool> execute(JoinRequestID id) async {
    return _requestRepository.remove(id);
  }
}
