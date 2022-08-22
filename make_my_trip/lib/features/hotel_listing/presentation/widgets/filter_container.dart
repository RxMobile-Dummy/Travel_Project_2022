import 'package:flutter/material.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';

import '../../../../core/theme/text_styles.dart';

class FilterContainer extends StatelessWidget {
  const FilterContainer({
    Key? key,
    this.rating,
    required this.filterText,
    required this.backColor,
    required this.textColor,
    required this.iconColor,
    required this.borderColor,
  }) : super(key: key);

  final bool? rating;
  final String filterText;
  final Color backColor, textColor, iconColor, borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: 18,
          vertical: (rating == false || rating == null) ? 8 : 6),
      decoration: BoxDecoration(
          color: backColor,
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(40)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          (rating == false || rating == null)
              ? const SizedBox()
              : Icon(
                  Icons.star_rounded,
                  color: iconColor,
                ),
          4.horizontalSpace,
          Text(
            filterText,
            style: AppTextStyles.labelDescriptionStyle
                .copyWith(fontWeight: FontWeight.w500, color: textColor),
          ),
        ],
      ),
    );
  }
}
