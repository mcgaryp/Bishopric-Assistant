import 'package:models/models/organization.dart';

///
/// $FILE_NAME.dart
/// bishopric-assistant
///
/// Created by Porter McGary on 3/19/22
/// Copyright 2022 Porter McGary. All rights reserved.
///

extension ListAuthorizationExtension on List<Authorization> {
  Authorization find(int rank) =>
      this.firstWhere((Authorization auth) => auth.rank == rank);
}
