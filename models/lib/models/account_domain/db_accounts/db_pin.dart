import 'package:models/models/account_domain/pin.dart';
import 'package:models/models/account_domain/pin_id.dart';
import 'package:models/shared/exceptions/exceptions.dart';

///
/// db_pin.dart
/// bishopric-assistant
///
/// Created by Joshua Bee on 3/23/22
/// Copyright 2022 Joshua Bee. All rights reserved.
///

class DBPin {
  static const String idKey = "database pin id";
  static const String expirationKey = "database pin expiration";
  static const String passcodeKey = "database pin passcode";

  int? expiration;
  String? id;
  String? passcode;

  DBPin({this.expiration, this.id, this.passcode});

  DBPin.fromMap(Map<String, dynamic> map)
      : this(
            expiration: map[expirationKey],
            id: map[idKey],
            passcode: map[passcodeKey]);

  DBPin.fromPin(Pin pin)
      : this(
          expiration: pin.expirationDateTime.microsecondsSinceEpoch,
          passcode: pin.passcode,
          id: pin.passcode,
        );

  Map<String, dynamic> get toMap => {
        idKey: id,
        expirationKey: expiration,
        passcodeKey: passcode,
      };

  PinID get toPinID {
    id ?? (throw IdDoesNotExistError(forObject: "DB pin ID"));
    return PinID(id!);
  }

  int get toExpiration {
    expiration ?? (throw Exception("DB expiration is null for pin"));
    return expiration!;
  }

  Pin get toPin {
    return Pin.fromDBPin(this);
  }

  String get toPasscode {
    passcode ?? (throw EmptyStringError(forObject: "DB pin passcode"));
    return passcode!;
  }
}
