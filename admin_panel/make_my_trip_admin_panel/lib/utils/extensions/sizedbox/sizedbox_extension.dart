import 'package:flutter/cupertino.dart';

extension SizedBoxExtension on num {
  /// Use to add horizontal space
  SizedBox get horizontalSpace => SizedBox(width: toDouble());

  /// Use to add vertical space
  SizedBox get verticalSpace => SizedBox(height: toDouble());
}
