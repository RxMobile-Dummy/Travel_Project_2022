import 'package:flutter/material.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';
import 'package:make_my_trip/utils/constants/string_constants.dart';

Widget titleWidget() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(StringConstants.populartours,
            style: AppTextStyles.unselectedLabelStyle),
        Text(StringConstants.viewallTxt,
            style: AppTextStyles.unselectedLabelStyle),
      ],
    ),
  );
}
