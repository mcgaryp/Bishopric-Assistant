import 'package:bishop_assistant_web_test_app/pages/assignment/archive_assignment_view.dart';
import 'package:bishop_assistant_web_test_app/pages/assignment/assignments_view.dart';
import 'package:bishop_assistant_web_test_app/pages/assignment/create_assignment_view.dart';
import 'package:bishop_assistant_web_test_app/widgets/widgets.dart';
import 'package:models/models/organization_domain/permissions.dart';

///
/// assignment_page.dart
/// bishopric-assistant
///
/// Created by Po on 2/5/22
/// Copyright 2022 Po. All rights reserved.
///

class AssignmentPage extends StatefulWidget {
  const AssignmentPage({Key? key}) : super(key: key);

  @override
  State<AssignmentPage> createState() => _AssignmentPageState();
}

class _AssignmentPageState extends State<AssignmentPage>
    with TickerProviderStateMixin {
  late List<Widget> children;
  late TabController _controller;
  late double width;
  late bool isMobile;
  int index = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Permissions currentUserPermissions =
        StateContainer.of(context).member.role.permissions;

    width = MediaQuery.of(context).size.width;
    isMobile = width < 700;

    _controller = TabController(length: isMobile ? 3 : 2, vsync: this);

    children = [
      AssignmentsView(),
      if (isMobile && currentUserPermissions >= Permissions.Reporter)
        CreateAssignmentView(),
      ArchiveAssignmentView(),
    ];

    if (isMobile) {
      return LightPage(
        navbar: BottomNavigationBar(
            currentIndex: index,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.list), label: sAssignments),
              if (currentUserPermissions >= Permissions.Reporter)
                BottomNavigationBarItem(
                    icon: Icon(Icons.create), label: sCreate),
              BottomNavigationBarItem(
                  icon: Icon(Icons.archive), label: sArchive),
            ],
            onTap: (int? index) {
              setState(() {
                this.index = index ?? 0;
              });
            }),
        child: children[index],
      );
    }

    return LightPage(
      tabBar: TabBar(
        controller: _controller,
        tabs: [
          Tab(text: sAssignments),
          if (isMobile) Tab(text: sCreate),
          Tab(text: sArchive),
        ],
      ),
      child: TabBarView(
        controller: _controller,
        children: children,
      ),
    );
  }
}