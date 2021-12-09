import 'package:bishop_assistant_web_test_app/repositories/firebase_organization_repository.dart';
import 'package:flutter/material.dart';
import 'package:models/models/account.dart';
import 'package:models/models/organization.dart';
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
    return this.data != oldWidget.data;
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
  Organization? _organization;
  Member? _member;

  // TODO: set is authenticated up properly if the user has been cached in
  //  shared preferences
  bool _isAuthenticated = false;
  bool _isOrganizationAssociated = false;
  bool _isMember = false;

  int? organizationRequests;

  Stream? _requestStream;

  /// [account] retrieves the account or notifies that an account is not valid
  /// and login is required
  Account get account {
    if (isAuthenticated) return _account!;
    throw PermissionDeniedError(reason: "UnAuthenticated User");
  }

  Organization get organization {
    if (hasOrganization) return _organization!;
    throw PermissionDeniedError(reason: "No Organizational Relationship");
  }

  Member get member {
    if (isMember) return _member!;
    throw PermissionDeniedError(reason: "Not a Member of an organization");
  }

  bool get isAuthenticated => _isAuthenticated;

  bool get hasOrganization => _isOrganizationAssociated;

  bool get isMember => _isMember;

  String get _now {
    DateTime time = DateTime.now();
    return "${time.hour}:${time.minute} ${time.second} sec ${time.millisecond} mSec";
  }

  void login(Account account) => setState(() {
        _isAuthenticated = true;
        _account = account;
      });

  void logout() => setState(() {
        _isAuthenticated = false;
        _account = null;
      });

  void setOrganization(OrganizationMember? org) => setState(() {
        if (org != null) {
          FirebaseOrganizationRepository repo =
              FirebaseOrganizationRepository();
          _requestStream = repo.findAllRequests(org.organization.id);
          _requestStream!.listen((event) {
            setOrganizationRequests(event.length);
          });
          _organization = org.organization;
          _member = org.member;
          _isOrganizationAssociated = true;
          _isMember = true;
        }
        if (org == null) {
          _requestStream = null;
          setOrganizationRequests(0);
          _organization = null;
          _member = null;
          _isOrganizationAssociated = false;
          _isMember = false;
        }
      });

  void setOrganizationRequests(int requests) {
    setState(() {
      if (requests <= 0)
        organizationRequests = null;
      else
        organizationRequests = requests;
    });
  }

  // Simple build method that just passes this state through
  // your InheritedWidget
  @override
  Widget build(BuildContext context) {
    return _InheritedStateContainer(data: this, child: widget.child);
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != StateContainerState) return false;
    return sameAs(other as StateContainerState);
  }

  bool sameAs(StateContainerState other) {
    return this.hasOrganization == other.hasOrganization &&
        this.organizationRequests == other.organizationRequests &&
        this.isMember == other.isMember &&
        this.isAuthenticated == other.isAuthenticated;
  }
}
