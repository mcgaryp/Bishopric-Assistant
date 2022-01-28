import 'package:bishop_assistant_web_test_app/pages/organization/display_organization.dart';
import 'package:bishop_assistant_web_test_app/pages/organization/edit_organization.dart';
import 'package:bishop_assistant_web_test_app/widgets/widgets.dart';

///
/// OrganizationPage.dart
/// bishop_assistant_web_test_app
///
/// Created by porter on 8/14/21
/// Copyright 2021 porter. All rights reserved.
///

class OrganizationPage extends StatefulWidget {
  const OrganizationPage({Key? key}) : super(key: key);

  @override
  State<OrganizationPage> createState() => _OrganizationPageState();
}

class _OrganizationPageState extends State<OrganizationPage> {
  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    return LightPage(
        child:
            isEditing ? EditOrganization(_save) : DisplayOrganization(_edit));
  }

  void _save() => _setIsEditing(false);

  void _edit() => _setIsEditing(true);

  void _setIsEditing(bool val) => setState(() => isEditing = val);
}
