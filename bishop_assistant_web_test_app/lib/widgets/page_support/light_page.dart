import 'package:the_assistant/widgets/page_support/app_bar/scaffold.dart';
import 'package:the_assistant/widgets/widgets.dart';
import 'package:models/models/account.dart';

///
/// light_page.dart
/// bishop_assistant_web_test_app
///
/// Created by Porter McGary on 8/13/21
/// Copyright 2021 Porter McGary. All rights reserved.
///

class LightPage extends StatelessWidget {
  final Widget child;
  final bool hasActionButton;
  final String? path;
  final BottomNavigationBar? navbar;
  final TabBar? tabBar;

  const LightPage(
      {required this.child,
      this.hasActionButton = false,
      this.path,
      this.navbar,
      this.tabBar,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final container = StateContainer.of(context).state;

    // Action items
    final List<ActionModel> actions = [
      ActionModel(label: sHome, path: rHome),
      // if (container == UserState.inOrganization)
      //   ActionModel(label: sEvents, path: rEvents),
      if (container == UserState.inOrganization)
        ActionModel(label: sAssignments, path: rAssignments),
      if (container == UserState.inOrganization)
        ActionModel(
          label: sOrganization,
          path: rOrganization,
        ),
      //notifications: 0), // TODO: request info
      if (kDebugMode) ActionModel(label: sTheme, path: rTheme),
      ActionModel(icon: Icons.person, path: rProfile),
    ];

    return SafeArea(
        bottom: false,
        top: false,
        child: MyScaffold.currentScaffold(context, actions, child,
            navigationBar: navbar, tabBar: tabBar));
  }
}
