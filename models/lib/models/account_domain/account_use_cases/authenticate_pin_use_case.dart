import 'package:models/models/account_domain/pin.dart';
import 'package:models/models/account_domain/pin_id.dart';
import 'package:models/models/account_domain/pin_repository.dart';
import 'package:models/shared/foundation.dart';

///
/// authenticate_pin_use_case.dart
/// bishopric-assistant
///
/// Created by Joshua Bee on 3/16/22
/// Copyright 2022 Joshua Bee. All rights reserved.
///
/// [AuthenticatePinUseCase] allows us to verify a pin for a beta tester
mixin AuthenticatePinUseCase {
  @required
  Future<bool> execute({required PinID pinID});
}

class DefaultAuthenticatePinUseCase implements AuthenticatePinUseCase {
  ///[_pinRepository] private variable with access to pin repository
  final PinRepository _pinRepository;

  DefaultAuthenticatePinUseCase(this._pinRepository);
  @override
  Future<bool> execute({required PinID pinID}) async {
    //Use find to look for the pin in the pin repository
    Pin? pin = await _pinRepository.find(pinID);
    pin ?? (throw PinNotFoundError());
    //check the expiration date
    if (pin.isExpired) {
      //throw permission denied with reason "expired"
      throw PermissionDeniedError(reason: "Beta access pin is expired");
    }
    return true;
  }
}
