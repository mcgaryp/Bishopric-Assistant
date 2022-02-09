import 'dart:async';

import 'package:bishop_assistant_web_test_app/repositories/repositories.dart';
import 'package:bishop_assistant_web_test_app/widgets/widgets.dart';
import 'package:models/models/account.dart';
import 'package:models/models/organization.dart';
import 'package:models/shared/exceptions.dart';
import 'package:package_info_plus/package_info_plus.dart';

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
  PackageInfo? _packageInfo;
  UserState _state = UserState.loadingIn;
  Account? _account;
  Organization? _organization;
  Member? _member;

  /// [account] retrieves the account or notifies that an account is not valid
  /// and login is required
  Account get account {
    if (_account == null) {
      if (kDebugMode) return Mocks().mockAccount;
      throw PermissionDeniedError(
          reason: "StateContainer UnAuthenticated User");
    }

    return _account!;
  }

  Organization get organization {
    if (_organization == null) {
      if (kDebugMode) return Mocks().mockOrganization;
      throw PermissionDeniedError(
          reason: "StateContainer No Organizational Relationship");
    }
    return _organization!;
  }

  Member get member {
    if (_member == null) {
      if (kDebugMode) return Mocks().mockMember;
      throw PermissionDeniedError(
          reason: "StateContainer Not a Member of an organization");
    }
    return _member!;
  }

  UserState get state => _state;

  String get now {
    DateTime time = DateTime.now();
    return "${time.hour}:${time.minute} ${time.second} sec ${time.millisecond} mSec";
  }

  String get copyRight {
    return "\u00A9 ${DateTime.now().year.toString()} ${sAppName}";
  }

  String get version {
    return _packageInfo?.version ?? "";
  }

  @override
  void initState() {
    _initPackageInfo();
    _initState();
    super.initState();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      this._packageInfo = info;
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
    return this._account == other._account &&
        this._organization == other._organization &&
        this._member == other._member &&
        this._state == other._state;
  }

  /*****************************************************************************
   * Streaming Setup
   ****************************************************************************/
  Stream<Account>? _accountStream;
  Stream<Organization>? _organizationStream;
  Stream<Member>? _memberStream;

  StreamSubscription? _accountSub;
  StreamSubscription? _organizationSub;
  StreamSubscription? _memberSub;

  /// Login Process
  Future<void> login(Credentials credentials) async {
    FirebaseAccountRepository accountRepo = FirebaseAccountRepository();
    AuthenticateAccountUseCase useCase =
        DefaultAuthenticateAccountUseCase(accountRepo);
    Account account = await useCase.execute(credentials);
    _updateAccount(account);
    _accountStream = accountRepo.findStreamed(account.id);
    _accountSub =
        _accountStream?.listen((Account account) => _updateAccount(account));
    _updateState(UserState.authenticated);
    await findOrganization();
  }

  Future<void> findOrganization() async {
    HasAssociatedOrganizationUseCase useCase =
        DefaultHasAssociatedOrganizationUseCase(FirebaseMemberRepository());
    OrganizationMember? relationship =
        await useCase.execute(accountID: account.id);
    relationship == null ? _noOrganization() : __organization(relationship);
  }

  Future<void> _noOrganization() async {
    nullOrganization();
    _updateState(UserState.noOrganization);
  }

  void nullOrganization() {
    _memberSub?.cancel();
    _organizationSub?.cancel();
    _organization = null;
    _member = null;
  }

  void _nullAccount() {
    _accountSub?.cancel();
    _account = null;
  }

  Future<void> __organization(OrganizationMember relationship) async {
    FirebaseMemberRepository memberRepo = FirebaseMemberRepository();
    FirebaseOrganizationRepository orgRepo = FirebaseOrganizationRepository();
    _memberStream = memberRepo.findStreamed(relationship.member.id);
    _memberSub =
        _memberStream?.listen((Member member) => _updateMember(member));
    _organizationStream = orgRepo.findStreamed(relationship.organization.id);
    _organizationSub = _organizationStream?.listen(
        (Organization organization) => _updateOrganization(organization));
    _updateState(UserState.inOrganization);
  }

  void _updateMember(Member member) => setState(() => _member = member);

  void _updateOrganization(Organization organization) =>
      setState(() => _organization = organization);

  void _updateAccount(Account account) => setState(() => _account = account);

  void _updateState(UserState state) => setState(() {
        _state = state;
      });

  /// Logout Process
  Future<void> logout() async {
    LogoutAccountUseCase useCase =
        DefaultLogoutAccountUseCase(FirebaseAccountRepository());
    if (await useCase.execute()) {
      _nullAccount();
      nullOrganization();
      _updateState(UserState.unauthenticated);
      await _disposeState();
    }
  }

  Future<void> _initState() async {
    try {
      GetStateUseCase useCase =
          DefaultGetStateUseCase(PreferencesStateRepository());
      _state = await useCase.execute();
    } catch (e) {
      if (kDebugMode) print(e);
      _state = UserState.unauthenticated;
    }
  }

  Future<void> _disposeState() async {
    SaveStateUseCase useCase =
        DefaultSaveStateUseCase(PreferencesStateRepository());
    if (!(await useCase.execute(_state))) {}
  }

  @override
  void dispose() {
    _disposeState();
    logout();
    super.dispose();
  }
}
