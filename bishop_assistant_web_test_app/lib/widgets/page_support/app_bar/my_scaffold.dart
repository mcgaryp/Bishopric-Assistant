import 'package:the_assistant/widgets/page_support/app_bar/action_model.dart';
import 'package:the_assistant/widgets/widgets.dart';

///
/// my_scaffold.dart
/// bishopric-assistant
///
/// Created by Po on 12/29/21
/// Copyright 2021 Po. All rights reserved.
///

class MyScaffold {
  static List<Widget> _compactActions = [];
  static List<Widget> _actions = [];
  static late Widget _child;
  static late StateContainerState _container;
  static BottomNavigationBar? _bottomNav;
  static TabBar? _tabBar;

  static Scaffold currentScaffold(
      BuildContext context, List<ActionModel> models, Widget child,
      {BottomNavigationBar? navigationBar, TabBar? tabBar}) {
    _tabBar = tabBar;
    _bottomNav = navigationBar;
    _container = StateContainer.of(context);
    _compactActions = [MyDrawerHeader(_container.account)];
    _child = child;
    // Full screen width and height
    double width = MediaQuery.of(context).size.width;

    if (width < 700) {
      for (ActionModel model in models) {
        if (model.label != null) _compactActions.add(model.compactButton);
      }
      return _compact(context);
    } else
      _actions = models.map((e) => e.webButton).toList();
    return _large(context);
  }

  // Footer
  static List<Widget> _footer(BuildContext context) => [
        MyButton(
          isExpanded: false,
          style: MyButtonStyle.errorText,
          label: sReportBug,
          onPressed: () => Navigator.pushNamed(context, rBugReport),
        ),
        MyButton(
          label: sLegal,
          onPressed: () => _navigate(context, rLegal),
          style: MyButtonStyle.text,
          isExpanded: false,
        ),
        MyButton(
          label: sPrivacy,
          onPressed: () => _navigate(context, rPrivacy),
          style: MyButtonStyle.text,
          isExpanded: false,
        ),
        MyButton(
          label: sSiteMap,
          onPressed: () => _navigate(context, rSiteMap),
          style: MyButtonStyle.text,
          isExpanded: false,
        ),
        Text(_container.version, style: body),
        Text(_container.copyRight, style: body),
      ];

  static void _navigate(BuildContext context, String path) =>
      Navigator.pushNamed(context, path);

  static Scaffold _compact(BuildContext context) => Scaffold(
        backgroundColor: lightGrey,
        drawer: SafeArea(
          child: Drawer(
              child: Column(
            children: [
              Expanded(child: ListView(children: _compactActions)),
              Wrap(
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.center,
                  runAlignment: WrapAlignment.center,
                  spacing: 20.0,
                  children: _footer(context)),
            ],
          )),
        ),
        appBar: AppBar(
          backgroundColor: darkPrimary,
          title: MyTitle(),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: padding8, right: padding8),
          child: _child,
        ),
        bottomNavigationBar: _bottomNav,
      );

  static Scaffold _large(BuildContext context) => Scaffold(
        backgroundColor: lightGrey,
        appBar: AppBar(
          bottom: _tabBar,
          backgroundColor: darkPrimary,
          leading: Logo(),
          centerTitle: false,
          title: MyTitle(),
          actions: _actions,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: padding8),
          child: _child,
        ),
        persistentFooterButtons: _footer(context),
      );
}
