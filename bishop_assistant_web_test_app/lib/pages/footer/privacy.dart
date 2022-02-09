import 'package:bishop_assistant_web_test_app/widgets/widgets.dart';
import 'package:models/models/organization.dart';

///
/// privacy.dart
/// bishop_assistant_web_test_app
///
/// Created by porter on 8/14/21
/// Copyright 2021 porter. All rights reserved.
///

class Privacy extends StatelessWidget {
  const Privacy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<DataColumn> columns = [DataColumn(label: Container())];
    columns.addAll(Permissions.values.map(
        (Permissions permission) => DataColumn(label: Text(permission.name))));

    return LightPage(
        child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: columns,
        rows: Features.rows,
      ),
    ));
  }
}

class FeatureInfo {
  final String _featureLabel;
  final Map<Permissions, bool> _map;

  FeatureInfo(
      {required String featureLabel, required Map<Permissions, bool> map})
      : assert(featureLabel.isNotEmpty),
        this._featureLabel = featureLabel,
        this._map = map;

  List<DataCell> get cells {
    List<DataCell> lst = [DataCell(Text(_featureLabel))];
    lst.addAll(_map.values
        .map((bool value) => value ? DataCell(_icon) : DataCell(_container)));
    return lst;
  }

  DataRow get row => DataRow(cells: cells);

  final Icon _icon = Icon(Icons.check);
  final Container _container = Container();
}

class Features {
  static List<DataRow> rows = [
    _createAssignment.row,
    _editAssignment.row,
    _viewAssignment.row,
    _deleteOrganization.row,
    _changeNameOfOrganization.row,
    _removeMembersFromOrganization.row,
    _changeMembersRoleInOrganization.row,
    _addMembersToOrganization.row,
  ];

  static FeatureInfo _createAssignment =
      FeatureInfo(featureLabel: "Create Assignment", map: {
    Permissions.Viewer: false,
    Permissions.Reporter: false,
    Permissions.Maintainer: true,
    Permissions.Creator: true,
  });

  static FeatureInfo _editAssignment =
      FeatureInfo(featureLabel: "Edit Assignment", map: {
    Permissions.Viewer: false,
    Permissions.Reporter: true,
    Permissions.Maintainer: true,
    Permissions.Creator: true,
  });

  static FeatureInfo _viewAssignment =
      FeatureInfo(featureLabel: "View Assignment", map: {
    Permissions.Viewer: true,
    Permissions.Reporter: true,
    Permissions.Maintainer: true,
    Permissions.Creator: true,
  });

  static FeatureInfo _deleteOrganization =
      FeatureInfo(featureLabel: "Delete Organization", map: {
    Permissions.Viewer: false,
    Permissions.Reporter: false,
    Permissions.Maintainer: false,
    Permissions.Creator: true,
  });

  static FeatureInfo _changeNameOfOrganization =
      FeatureInfo(featureLabel: "Change Organization Name", map: {
    Permissions.Viewer: false,
    Permissions.Reporter: false,
    Permissions.Maintainer: false,
    Permissions.Creator: true,
  });

  static FeatureInfo _removeMembersFromOrganization =
      FeatureInfo(featureLabel: "Remove Member From Organization", map: {
    Permissions.Viewer: false,
    Permissions.Reporter: false,
    Permissions.Maintainer: false,
    Permissions.Creator: true,
  });

  static FeatureInfo _changeMembersRoleInOrganization =
      FeatureInfo(featureLabel: "Change Members Role In Organization", map: {
    Permissions.Viewer: false,
    Permissions.Reporter: false,
    Permissions.Maintainer: true,
    Permissions.Creator: true,
  });

  static FeatureInfo _addMembersToOrganization =
      FeatureInfo(featureLabel: "Add Members to Organization", map: {
    Permissions.Viewer: false,
    Permissions.Reporter: false,
    Permissions.Maintainer: true,
    Permissions.Creator: true,
  });
}
