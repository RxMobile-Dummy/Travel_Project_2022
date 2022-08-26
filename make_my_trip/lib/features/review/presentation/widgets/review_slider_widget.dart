import 'package:flutter/material.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';

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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 12.0, left: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                fieldName,
                style: AppTextStyles.labelDescriptionStyle,
              ),
              Text(
                value.toStringAsFixed(1),
                style: AppTextStyles.infoContentStyle,
              )
            ],
          ),
        ),
        SliderTheme(
          child: Slider(
            value: value,
            min: 0.0,
            max: 5.0,
            thumbColor: MakeMyTripColors.colorWhite,
            activeColor: MakeMyTripColors.accentColor,
            onChanged: (val) {},
          ),
          data: SliderTheme.of(context).copyWith(
            thumbShape: SliderComponentShape.noThumb,
          ),
        )
      ],
    );
  }
}
