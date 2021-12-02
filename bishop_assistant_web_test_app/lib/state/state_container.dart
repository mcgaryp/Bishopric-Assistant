import 'package:flutter/material.dart';
import 'package:models/models/account.dart';
import 'package:models/shared/exceptions.dart';

///
/// state_container.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 12/1/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

/// For reference https://ericwindmill.com/articles/inherited_widget/

/// [_InheritedStateContainer] is an inherited widget it's data is manipulated
/// in the [StateContainerState] class
class _InheritedStateContainer extends InheritedWidget {
  // Data is your entire state. In this case it is our user session variables
  final StateContainerState data;

  // A child must pass through to the state.
  _InheritedStateContainer(
      {Key? key, required this.data, required Widget child})
      : super(key: key, child: child);

  // This is a built in method which you can use to check if
  // any state has changed. If not, no reason to rebuild all the widgets
  // that rely on your state.
  @override
  bool updateShouldNotify(_InheritedStateContainer oldWidget) {
    // We only want to update the widgets if the authentication state has changed
    return data.isAuthenticated != oldWidget.data.isAuthenticated;
  }
}

/// [StateContainer] holds and maintains the state of the session variables
class StateContainer extends StatefulWidget {
  // Again pass through a child
  final Widget child;

  const StateContainer({Key? key, required this.child}) : super(key: key);

  // This is the secret sauce. Write your own 'of' method that will behave
  // Exactly like MediaQuery.of and Theme.of
  // It basically says 'get the data from the widget of this type.
  static StateContainerState of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_InheritedStateContainer>()!
        .data;
  }

  @override
  StateContainerState createState() => StateContainerState();
}

class StateContainerState extends State<StateContainer> {
  // This is the session. Place variables here that should be known as session
  // variables
  /// [_account] of the user containing information about the user specifically
  Account? _account;
  // TODO: set is authenticated up properly if the user has been cached in
  //  shared preferences
  bool _isAuthenticated = false;

  /// [account] retrieves the account or notifies that an account is not valid
  /// and login is required
  Account get account {
    if (_account != null) return _account!;
    throw PermissionDeniedError(reason: "UnAuthenticated User");
  }

  bool get isAuthenticated => _isAuthenticated;

  Future login(Account account) async {
    setState(() {
      _isAuthenticated = true;
      _account = account;
    });
  }

  void logout() => setState(() {
        _isAuthenticated = false;
        _account = null;
      });

  // Simple build method that just passes this state through
  // your InheritedWidget
  @override
  Widget build(BuildContext context) {
    return _InheritedStateContainer(data: this, child: widget.child);
  }
}
