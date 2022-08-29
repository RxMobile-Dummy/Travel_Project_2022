import 'package:flutter/material.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';

typedef StringCallback = void Function(double val);

class ReviewSliderWidget extends StatelessWidget {
  const ReviewSliderWidget({
    Key? key,
    required this.fieldName,
    required this.value,
    required this.context,
  }) : super(key: key);
  final String fieldName;
  final double value;
  final BuildContext context;
  @override
  Widget build(context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                fieldName,
                style: AppTextStyles.labelDescriptionStyle,
              ),
              Text(
                value.toStringAsFixed(1),
                style: AppTextStyles.infoContentStyle.copyWith(fontSize: 14),
              )
            ],
          ),
          4.verticalSpace,
          LinearProgressIndicator(
            value: value / 5,
          ),
        ],
      ),
    );
  }
}
