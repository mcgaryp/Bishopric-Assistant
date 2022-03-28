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
    return ComingSoon();
    // List<DataColumn> columns = [DataColumn(label: Container())];
    // columns.addAll(Permissions.values.map(
    //     (Permissions permission) => DataColumn(label: Text(permission.name))));
    //
    // return LightPage(
    //     child: SingleChildScrollView(
    //   scrollDirection: Axis.horizontal,
    //   child: DataTable(
    //     columns: columns,
    //     rows: Features.rows,
    //   ),
    // ));
  }
}

// TODO: Restructure with Authorization
@Deprecated("This needs to change to a new Feature portion")
class FeatureInfo {
  final String _featureLabel;
  @Deprecated("Needs to use Authorization")
  final Map<Authorization, bool> _map;

  FeatureInfo(
      {required String featureLabel, required Map<Authorization, bool> map})
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

@Deprecated("Needs to have new features created or changed")
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
    Authorization(name: "Viewer", rank: 0): false,
    Authorization(name: "Reporter", rank: 1): false,
    Authorization(name: "Maintainer", rank: 2): true,
    Authorization(name: "Creator", rank: 3): true,
  });

  static FeatureInfo _editAssignment =
      FeatureInfo(featureLabel: "Edit Assignment", map: {
    Authorization(name: "Viewer", rank: 0): false,
    Authorization(name: "Reporter", rank: 1): true,
    Authorization(name: "Maintainer", rank: 2): true,
    Authorization(name: "Creator", rank: 3): true,
  });

  static FeatureInfo _viewAssignment =
      FeatureInfo(featureLabel: "View Assignment", map: {
    Authorization(name: "Viewer", rank: 0): true,
    Authorization(name: "Reporter", rank: 1): true,
    Authorization(name: "Maintainer", rank: 2): true,
    Authorization(name: "Creator", rank: 3): true,
  });

  static FeatureInfo _deleteOrganization =
      FeatureInfo(featureLabel: "Delete Organization", map: {
    Authorization(name: "Viewer", rank: 0): false,
    Authorization(name: "Reporter", rank: 1): false,
    Authorization(name: "Maintainer", rank: 2): false,
    Authorization(name: "Creator", rank: 3): true,
  });

  static FeatureInfo _changeNameOfOrganization =
      FeatureInfo(featureLabel: "Change Organization Name", map: {
    Authorization(name: "Viewer", rank: 0): false,
    Authorization(name: "Reporter", rank: 1): false,
    Authorization(name: "Maintainer", rank: 2): false,
    Authorization(name: "Creator", rank: 3): true,
  });

  static FeatureInfo _removeMembersFromOrganization =
      FeatureInfo(featureLabel: "Remove Member From Organization", map: {
    Authorization(name: "Viewer", rank: 0): false,
    Authorization(name: "Reporter", rank: 1): false,
    Authorization(name: "Maintainer", rank: 2): false,
    Authorization(name: "Creator", rank: 3): true,
  });

  static FeatureInfo _changeMembersRoleInOrganization =
      FeatureInfo(featureLabel: "Change Members Role In Organization", map: {
    Authorization(name: "Viewer", rank: 0): false,
    Authorization(name: "Reporter", rank: 1): false,
    Authorization(name: "Maintainer", rank: 2): true,
    Authorization(name: "Creator", rank: 3): true,
  });

  static FeatureInfo _addMembersToOrganization =
      FeatureInfo(featureLabel: "Add Members to Organization", map: {
    Authorization(name: "Viewer", rank: 0): false,
    Authorization(name: "Reporter", rank: 1): false,
    Authorization(name: "Maintainer", rank: 2): true,
    Authorization(name: "Creator", rank: 3): true,
  });
}
