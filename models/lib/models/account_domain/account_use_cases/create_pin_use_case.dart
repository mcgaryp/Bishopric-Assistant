import 'package:models/models/account.dart';

///
/// create_pin_use_case.dart
/// bishopric-assistant
///
/// Created by Joshua Bee on 3/16/22
/// Copyright 2022 Joshua Bee. All rights reserved.
///

///[CreatePinUseCase] describes requirements to create a pin
mixin CreatePinUseCase {
  ///[execute] creates a pin given a [pin]
  @required
  Future<bool> execute({required Pin pin});
}

class DefaultCreatePinUseCase implements CreatePinUseCase {
  PinRepository _pinRepository;

  DefaultCreatePinUseCase(this._pinRepository);

  @override
  Future<bool> execute({required Pin pin}) async {
    //check if it already exists
    // if (await _pinRepository.find(pin.id) != null)
    //   throw PinAlreadyExistsError();
    //insert it
    return await _pinRepository.insert(pin);
  }
}
