import 'package:flutter/material.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';

import '../../../../core/theme/make_my_trip_colors.dart';

class FeaturesItemWidget extends StatelessWidget {
  const FeaturesItemWidget({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: .5,
      child: Row(
        children: [
          const Icon(
            Icons.circle,
            size: 12,
            color: MakeMyTripColors.color30gray,
          ),
          8.horizontalSpace,
          Expanded(
            child: Text(
              text,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.infoContentStyle,
            ),
          )
        ],
      ),
    );
  }
}
