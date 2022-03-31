import 'dart:math';

import 'package:models/models/account_domain/db_accounts/db_pin.dart';
import 'package:models/models/account_domain/pin_id.dart';
import 'package:models/shared/domain_driven_design/entity.dart';
import 'package:models/shared/exceptions/exceptions.dart';

///
/// pin.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 12/3/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

class Pin extends Entity<Pin> {
  static const String expirationKey = "Pin Expiration";
  static const String passcodeKey = "Pin Passcode";
  static const String idKey = "Pin ID";

  final DateTime _expiration;
  late final String _passcode;
  late final PinID? _id;

  PinID get id {
    if (_id == null) throw IdDoesNotExistError(forObject: "Pin");
    return _id!;
  }

  /// Constructor of [Pin]
  Pin({PinID? id})
      : this._expiration = DateTime.now().add(Duration(minutes: 30)),
        super(id) {
    String temp = _generatePin;
    this._passcode = temp;
    if (id == null) this._id = PinID(temp);
  }

  Pin.fromDBPin(DBPin dbPin)
      : this._id = dbPin.toPinID,
        this._expiration =
            DateTime.fromMicrosecondsSinceEpoch(dbPin.toExpiration),
        this._passcode = dbPin.toPasscode,
        super(dbPin.toPinID);

  static String get _generatePin {
    String code = "";
    Random random = Random();

    while (code.length != 4) {
      code += random.nextInt(10).toString();
    }

    return code;
  }

  String get passcode => _passcode;

  bool get isExpired => DateTime.now().isAfter(_expiration);

  DateTime get expirationDateTime => _expiration;

  String get expiration =>
      "${_expiration.month}/${_expiration.day}/${_expiration.year} at "
      "${_expiration.hour}:${_expiration.minute}";

  bool isValid(String pin) => pin == passcode;

  @override
  String toString() {
    return "$passcode expires on $expiration";
  }

  @override
  bool sameIdentityAs(Pin other) {
    return other._expiration == this._expiration &&
        other._passcode == this._passcode &&
        other._id == this._id;
  }

  @override
  Map<String, dynamic> get toMap => {
        expirationKey: _expiration.microsecondsSinceEpoch,
        passcodeKey: _passcode,
        idKey: _id?.id,
      };
}
